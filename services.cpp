#include "services.h"
#include <QSqlQuery>
#include <QDebug>
#include <QCryptographicHash>
#include <QDateTime>
Services::Services(QQmlContext *ctxt)
{
    _mctxt = ctxt;
    if(_mcon.doConnect("QMYSQL", "127.0.0.1", 3306, "test", "root", ""))
        qDebug("Connect Successfully");
    else
        qDebug("Failed to connect dtb");
    //_mcon.disconnect();
}
QVariant Services::getTransactionData(QString table)
{
    qDebug("get transaction");
    _list.clear();
    QSqlQuery query(_mcon.con());
    query.exec("SELECT * FROM " + table + " LIMIT " + QString::number(_head) + ", " + QString::number(MINPAGESIZE));
    while(query.next())
    {
        _head++;
        qDebug("get data");
        QVariantMap item;
        item.insert("nodeID", query.value("nodeID").toString());
        qDebug() << "nodeID " << query.value("nodeID").toString();
        item.insert("temperature", query.value("temperature").toString());
        item.insert("humidity", query.value("humidity").toString());
        _list.append(item);
    }
    qDebug() << "total: " << _getTotalRecords();
    return QVariant::fromValue<QVariantList>(_list);
}

bool Services::updateTransaction(int id, QString nodeID, QString temperature, QString humidity)
{
    return true;
}
bool Services::insertTransaction(QString nodeID, QString temperature, QString humidity)
{
    return true;
}
bool Services::deleteTransaction(int id)
{

}
int Services::_getTotalRecords()
{
    QSqlQuery query(_mcon.con());
    query.exec("SELECT COUNT(*) FROM " + _table);
    if(query.next())
    {
        return query.value(0).toInt();
    }
    return 0;
}

void Services::refreshList()
{
    emit listChange();
}

QVariantList Services::getList()
{
    qDebug("get List");
    //QString table = "sensor"; //FIXME, should be get from combobox
    if(_head == _getTotalRecords())
    {
        qDebug("Last of data");
        return _data;
    }
   
    QSqlQuery query(_mcon.con());
    query.exec("SELECT * FROM " + _table + " LIMIT " + QString::number(_head) + ", " + QString::number(MINPAGESIZE));
    _data.clear();
    while(query.next())
    {
        QVariantMap item;
        if(_table == "sensor")
        {
            qDebug("get sensor data");
            item.insert("nodeID", query.value("nodeID").toString());
            qDebug() << "nodeID " << query.value("nodeID").toString();
            item.insert("temperature", query.value("temperature").toString());
            item.insert("humidity", query.value("humidity").toString());
        }else
        {
            qDebug("get mesh data");
            item.insert("nodeID", query.value("nodeID").toString());
            qDebug() << "nodeID " << query.value("nodeID").toString();
            item.insert("type", query.value("type").toString());
            item.insert("group", query.value("group1").toString());
        }

        _data.append(item);
    }
    qDebug() << "total: " << _getTotalRecords();
    //return QVariant::fromValue<QVariantList>(_list);
    return _data;
}
int Services::getLastPage()
{
    _head = _getTotalRecords() - MINPAGESIZE;
    refreshList();
}

int Services::getPrevPage()
{
    _head -= MINPAGESIZE;
    if(_head < 0) _head = 0;
    refreshList();
    return !_head;
}

int Services::getNextPage()
{
    _head += MINPAGESIZE;
    refreshList();
    qDebug() << "head is " << _head;
    if((_head + MINPAGESIZE) >= _getTotalRecords())
        return 1;
    else
        return 0;
}
