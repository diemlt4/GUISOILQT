#include "mymqtt.h"

MyMqtt::MyMqtt()
{
    if(_client) return;
    _client = new QMqttClient(this);
    _client->setHostname("broker.hivemq.com");
    _client->setPort(1883);
    _client->connectToHost();
    if(_client->state()!= QMqttClient::Disconnected)
    {
        qDebug("mqtt connected");
        _client->subscribe(_topic, 0);
    }
    else
    {
        qDebug("mqtt failed connected");
    }

}

MyMqttSubscription* MyMqtt::subscribe(const QString topic)
{
    auto sub = QMqttClient::subscribe(topic, 0);
    auto result = new MyMqttSubscription(sub, this);
    return result;
}
MyMqttSubscription::MyMqttSubscription(QMqttSubscription *s, MyMqtt *c)
    : _sub(s)
    , _client(c)
{
    connect(_sub, &QMqttSubscription::messageReceived, this, &MyMqttSubscription::handleMessage);
    m_topic = _sub->topic();
}
MyMqttSubscription::~MyMqttSubscription()
{
}

void MyMqttSubscription::handleMessage(const QMqttMessage &qmsg)
{
    //emit messageReceived(qmsg.payload());
    qDebug() << "receive msg: " << qmsg.payload();
}
