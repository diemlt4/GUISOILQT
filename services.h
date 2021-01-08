#ifndef SERVICES_H
#define SERVICES_H

#include <QObject>
#include "dtbconnection.h"
#include <QStringList>
#include <QQmlContext>
#include <QQmlListProperty>

#define MINPAGESIZE 2

class QString;
class Services : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList myModel READ getList NOTIFY listChange)
public slots:
    QVariantList getList();
    void refreshList();
public:
    Services(QQmlContext *ctxt);

    Q_INVOKABLE bool updateTransaction(int id, QString nodeID, QString temperature, QString humidity);
    Q_INVOKABLE bool insertTransaction(QString nodeID, QString temperature, QString humidity);
    Q_INVOKABLE bool deleteTransaction(int id);
    Q_INVOKABLE QVariant getTransactionData(QString table);
    Q_INVOKABLE int getNextPage();
    Q_INVOKABLE int getPrevPage();
    Q_INVOKABLE int getFirstPage() {_head = 0; refreshList();}
    Q_INVOKABLE int getLastPage();
    Q_INVOKABLE void setTable(QString table) {_table = table; _head = 0;}
signals:
    void listChange();
private:
    int _getTotalRecords();
    DTBConnection _mcon;
    QQmlContext *_mctxt;
    int _head = 0;
    int _oldHead = 0;
    int _tail = MINPAGESIZE;
    QVariantList _list;
    QVariantList _data;
    QString _table = "sensor";
};

#endif // SERVICES_H
