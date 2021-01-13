#ifndef MYMQTT_H
#define MYMQTT_H
#include <QMqttClient>
#define TOPIC "diemlt4/abc"
class MyMqtt;

class MyMqttSubscription : public QObject
{
    Q_OBJECT
public:
    MyMqttSubscription(QMqttSubscription *s, MyMqtt *c);
    ~MyMqttSubscription();

Q_SIGNALS:
    void topicChanged(QString);
    void messageReceived(const QString &msg);

public slots:
    void handleMessage(const QMqttMessage &qmsg);

private:
    Q_DISABLE_COPY(MyMqttSubscription)
    QMqttSubscription *_sub;
    MyMqtt *_client;
    QMqttTopicFilter m_topic;
};

class MyMqtt : public QMqttClient
{
    Q_OBJECT
public:
    MyMqtt();
    Q_INVOKABLE MyMqttSubscription *subscribe(const QString topic);
    Q_DISABLE_COPY(MyMqtt);
private:
    QMqttClient *_client = nullptr;
    QString _topic = "diemlt4/abc";
};

#endif // MYMQTT_H
