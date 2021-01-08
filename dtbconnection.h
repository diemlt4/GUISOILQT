#ifndef DTBCONNECTION_H
#define DTBCONNECTION_H
#include <QtSql/QSqlDatabase>

class DTBConnection
{
public:
    DTBConnection();
    QSqlDatabase con() const;
    bool doConnect (QString driver, QString hostname, int port, QString database, QString username, QString password);
    void disconnect() {_mdb.close();}
private:
    QSqlDatabase _mdb;
};

#endif // DTBCONNECTION_H
