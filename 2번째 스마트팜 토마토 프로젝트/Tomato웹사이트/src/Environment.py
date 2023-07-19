from flask import Flask, render_template, request
import datetime
import tensorflow as tf
import numpy as np

app=Flask(__name__)

X = tf.keras.Input(shape=(None, 12), dtype=tf.float32)
y = tf.keras.Input(shape=(None, 1), dtype=tf.float32)

W = tf.Variable(tf.random_normal([12, 1]), name="weight")
b = tf.Variable(tf.random_normal([1]), name="bias")

hypothesis = tf.matmul(X,W)+b

saver = tf.train.Saver()
model = tf.global_variables_initializer()

sess = tf.Session()
sess.run(model)
save_path = "./model/DNN_model_ph.pkl"
saver.restore(sess, save_path)

@app.route("/best_env", methods=["GET", "POST"])
def index():
    if request.method=="GET":
        return render_template("best_env.html")
    if request.method=="POST":
        EC_feed = float(request.form["EC_feed"])
        EC_bact = float(request.form["EC_bact"])
        pH_feed = float(request.form["pH_feed"])
        pH_bact = float(request.form["pH_bact"])
        CO2 = float(request.form["CO2"])
        avg_temp = float(request.form["avg_temp"])
        J_Day = float(request.form["J_Day"])
        ground_temp = float(request.form["ground_temp"])
        temp_feed = float(request.form["temp_feed"])
        temp_bact = float(request.form["temp_bact"])
        EC_rate = float(request.form["EC_rate"])
        pH_rate = float(request.form["pH_rate"])

        fruit_weight = 0

        data = ((EC_feed, EC_bact, pH_feed, pH_bact, CO2, avg_temp, J/Day, ground_temp, temp_feed, temp_bact, EC_rate, pH_rate),
                (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))

        arr = np.array(data, dtype=np.float32)

        x_data = arr[0:12]
        dict = sess.run(hypothesis, feed_dict ={X_x_data})

        fruit_weight=dict[0]
        return render_template("best_env.html", fruit_weight=fruit_weight)

    if __name__ =="__main__":
        app.run(host="0.0.0.0", port="5000")