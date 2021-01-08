#include "dtbconnection.h"

DTBConnection::DTBConnection()
{

}

bool DTBConnection::doConnect(QString driver, QString hostname, int port, QString database, QString username, QString password)
{
    _mdb = QSqlDatabase::addDatabase(driver);
    _mdb.setHostName(hostname);
    _mdb.setPort(port);
    _mdb.setDatabaseName(database);
    _mdb.setUserName(username);
    _mdb.setPassword(password);
    return _mdb.open();
}

QSqlDatabase DTBConnection::con() const
{
    return _mdb;
}
