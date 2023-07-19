import io
import torch
import cv2
import numpy as np
import tensorflow as tf
from re import DEBUG, sub
from flask import Flask, render_template, session, request, url_for, send_file, Response
import os
import subprocess
from subprocess import Popen
import re
import requests
import shutil
import time
import base64
import time
from PIL import Image
from ultralytics import YOLO
from werkzeug.utils import secure_filename, send_from_directory
from tensorflow.keras.models import load_model
import pandas as pd
import json
import pickle
from sklearn.linear_model import Ridge
from sklearn.preprocessing import MinMaxScaler, StandardScaler
from sklearn.model_selection import train_test_split

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("tomato.html")

@app.route("/introduction")
def introduction():
    return render_template("introduction.html")

@app.route("/method")
def howto():
    return render_template("accordion.html")

@app.route("/board")
def board():
    return render_template("board.html")

@app.route("/weight")
def weight():
    return render_template("fruit_weight.html")

@app.route("/sugar")
def sugar():
    return render_template("sugar.html")

@app.route("/ph")
def ph():
    return render_template("ph.html")

@app.route("/best_env")
def best_env():
    return render_template("best_env.html")

@app.route("/detecting", methods=["POST"])
def predict():
    if request.method=="POST":
        if "myfile" in request.files:
            f = request.files["myfile"]
    # return "<h2>" + f.filename +"이 잘 전달됨</h2>"
            file_extension = f.filename.rsplit('.', 1)[1].lower()
            file_name = f.filename.rsplit('.', 1)[0]
            save_path = "./static/images/{}".format(f.filename)
            f.save(save_path)
            if file_extension =="jpg":
                img = cv2.imread(save_path)

                yolo = YOLO('best_7classes.pt')
                detections = yolo.predict(source=img, save=True)
                return display(f.filename)
            elif file_extension =="mp4":
                cap = cv2.VideoCapture(save_path)

            frame_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
            frame_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

            fourcc = cv2.VideoWriter_fourcc(*"mp4v")
            out = cv2.VideoWriter("output.mp4", fourcc, 30.0, (frame_width, frame_height))

            model = YOLO('best_7classes.pt')

            while cap.isOpened():
                ret, frame = cap.read()
                if not ret:
                    break

                result = model(frame, save=True)
                print(result)
                cv2.waitKey(1)
            #
                res_plotted = result[0].plot()
                cv2.imshow("result", res_plotted)


                out.write(res_plotted)

                if cv2.waitKey(1) == ord('q'):
                    break
            cv2.destroyAllWindows()
            cap.release()

            return video_feed()

def display(filename):
    folder_path = "runs/detect"
    subfolders = [f for f in os.listdir(folder_path) if os.path.isdir(os.path.join(folder_path, f))]
    latest_subfolder = max(subfolders, key=lambda x : os.path.getctime(os.path.join(folder_path, x)))
    directory = folder_path+"/"+latest_subfolder
    files = os.listdir(directory)
    latest_file = files[0]
    environ = request.environ
    return send_from_directory(directory, latest_file, environ)

def get_frame():
    folder_path = os.getcwd()
    mp4_files="output.mp4"
    video = cv2.VideoCapture(mp4_files) # detected video path
    while True:
        success, image = video.read()
        if not success:
            break
        ret, jpg = cv2.imencode(".jpg,", image)
        yield(b'--frame\r\n' 
            b'Content-Type: image/jpg\r\n\r\n'+jpg.tobytes()+b'\r\n\r\n')
        time.sleep(0.1)

@app.route("/video_feed")
def video_feed():
    # print("function called")
    return Response(get_frame(), mimetype="multipart/x-mixed-replace; boundary=frame")

@app.route("/detecting")
def detecting():
    return render_template("detect.html")

@app.route("/growth", methods=["POST"])
def pred_growth():
    if request.method=="POST":
        if "myfile" in request.files:
            f = request.files["myfile"]
    # return "<h2>" + f.filename +"이 잘 전달됨</h2>"
            file_extension = f.filename.rsplit('.', 1)[1].lower()
            file_name = f.filename.rsplit('.', 1)[0]
            save_path = "./static/images/{}".format(f.filename)
            f.save(save_path)
            if file_extension =="jpg":
                img = cv2.imread(save_path)

                yolo = YOLO('best_light.pt')
                detections = yolo.predict(source=img, save=True)
                return display(f.filename)

            elif file_extension =="mp4":
                cap = cv2.VideoCapture(save_path)
            #
            frame_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
            frame_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
            #
            fourcc = cv2.VideoWriter_fourcc(*"mp4v")
            out = cv2.VideoWriter("output.mp4", fourcc, 30.0, (frame_width, frame_height))
            #
            model = YOLO('best_light.pt')
            #
            while cap.isOpened():
                ret, frame = cap.read()
                if not ret:
                    break
                result = model(frame, save=True)
                print(result)
                cv2.waitKey(1)
            #
                res_plotted = result[0].plot()
                cv2.imshow("result", res_plotted)

                out.write(res_plotted)

                if cv2.waitKey(1) == ord('q'):
                    break
            cv2.destroyAllWindows()
            cap.release()
            #
            return video_feed()

@app.route("/growth")
def growth():
    return render_template("growth.html")

@app.route("/best_env", methods=["POST"])
def env_info():
    if request.method=="POST":
        input_data = {
            "EC급액": float(request.form["EC_feed"]),
            "EC배액": float(request.form["EC_bact"]),
            "pH급액": float(request.form["pH_feed"]),
            "pH배액": float(request.form["pH_bact"]),
            "내부이산화탄소": float(request.form["CO2"]),
            "평균온도": float(request.form["avg_temp"]),
            "J/Day": float(request.form["J_Day"]),
            "온도토양": float(request.form["ground_temp"]),
            "온도급액": float(request.form["temp_feed"]),
            "온도배액": float(request.form["temp_bact"]),
            "EC비율": float(request.form["EC_rate"]),
            "pH비율": float(request.form["pH_rate"])
        }


        tom_weight = pd.read_csv("tom_mul_weight_seed_98_1.csv", encoding="utf-8", index_col=0)
        input_data_weight=[]
        input_data_weight.append([(input_data[col] - tom_weight[col].mean()) / tom_weight[col].std() for col in tom_weight.columns[:-3]])
        X = tom_weight[tom_weight.columns[:-3]]
        y = tom_weight["과중"]
        scaler = StandardScaler()
        X = scaler.fit_transform(X)

        X_train, X_test, y_train, y_test = train_test_split(X, y)
        print(X_train, y_train)
        ridge = Ridge(alpha=0.01)
        ridge.fit(X_train, y_train)
        pred = ridge.predict(input_data_weight)

        if pred >= 600:
            pred = 600
        elif pred <=0:
            pred =250

        print(pred)

        tom_sugar = pd.read_csv("tom_mul_sugar.csv", encoding="utf-8", index_col=0)
        X_sugar = tom_sugar[tom_sugar.columns[:-3]]
        y_sugar = tom_sugar["당도"]
        scaler = StandardScaler()
        X_sugar = scaler.fit_transform(X_sugar)
        input_data_sugar = []
        input_data_sugar.append([(input_data[col] - tom_sugar[col].mean()) / tom_sugar[col].std() for col in tom_sugar.columns[:-3]])
        X_train, X_test, y_train, y_test= train_test_split(X_sugar, y_sugar)
        model_ridge = Ridge(alpha=0.001)
        model_ridge.fit(X_train, y_train)
        pred2 = model_ridge.predict(input_data_sugar)

        if pred2 >= 7:
            pred2 = 6.5
        elif pred2 <=0:
            pred2 = 4

        print(pred2)

        # data = [EC_feed, EC_bact, pH_feed, pH_bact, CO2, avg_temp, J_Day, ground_temp, temp_feed, temp_bact, EC_rate, pH_rate]
        tom_ph = pd.read_csv("tom_mul_ph_seed_100.csv", encoding="utf-8", index_col=0)
        input_data2 = []
        input_data2.append([(input_data[col] - tom_ph[col].mean()) / tom_ph[col].std() for col in tom_ph.columns[:-3]])
        input_data3 = np.array(input_data2, dtype=np.float32).reshape(1, -1)
        print(input_data3)

        model_path = "./model/DNN_model_ph.h5"
        loaded_model = load_model(model_path)
        # input_a = 2.95
        label_dict = {0: "3.5", 1: "4.0", 2: "4.5"}
        pred3 = loaded_model.predict(input_data3)
        pred_result = label_dict[np.argmax(pred3)]

    return ["과중 : {}".format(str(pred)), "당도 : {}".format(str(pred2)), "산도 : {}".format(str(pred_result))]

if __name__ =="__main__":
    app.run(host="0.0.0.0", port="5000")
