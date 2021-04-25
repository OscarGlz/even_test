import pyodbc
from flask import Flask, abort
from flask_restful import Api, Resource
import re

server = 'tcp:DESKTOP-C91GDRB'
database = 'even'
username = 'test'
password = '123abc'


app = Flask(__name__)
api = Api(app)

cnxn = pyodbc.connect("DRIVER={ODBC Driver 17 for SQL Server};"
                      "SERVER=" + server + ';DATABASE=' + database + ';UID=' + username + ';PWD=' + password)
cursor = cnxn.cursor()


def leadExists(lead_uuid):
    cursor.execute("Select count(*) from [even].[dbo].[rate_tables] where lead_uuid='" + lead_uuid + "'")
    row = cursor.fetchone()
    if row[0] > 0:
        return True
    else:
        return False


def isValidGUID(str):
    regex = "^[{]?[0-9a-fA-F]{8}" + "-([0-9a-fA-F]{4}-)" + "{3}[0-9a-fA-F]{12}[}]?$"

    p = re.compile(regex)

    print("uidd: " + str)
    if str == None:
        return False

    if re.search(p, str):
        return True
    else:
        return False


class getStatistics(Resource):
    def get(self, lead_uuid):
        if isValidGUID(lead_uuid):
            if leadExists(lead_uuid):
                cursor.execute("exec get_lead_statistics @lu ='" + lead_uuid + "'")
                row = cursor.fetchone()
                return {"lead_uuid": row[2], "Lowest Offer APR": str(row[0]), "Unique Demand count": str(row[1])}
            else:
                abort(404, lead_uuid + " lead uuid doesn't exists")

        else:
            abort(404, lead_uuid + " lead uuid format is not valid")



class getLeadDetail(Resource):
    def get(self, lead_uuid):
        if isValidGUID(lead_uuid):
            if leadExists(lead_uuid):
                cursor.execute("exec get_lead_dataset @lu ='" + lead_uuid + "'")
                row = cursor.fetchone()
                leadUID = {"lead_uuid": lead_uuid, "rate_table_id": row[1], "detail": []}
                for row in cursor:
                    detail={}
                    detail = {"Rate table offer id": str(row[2]), "Offer APR": str(row[3]), "Offer monthly payment": str(row[4])}
                    leadUID["detail"].append(detail)
                return leadUID

            else:
                abort(404, lead_uuid + " lead uuid doesn't exists")
        else:
            abort(404, lead_uuid + " lead uuid format is not valid")


api.add_resource(getStatistics, "/stats/<string:lead_uuid>")
api.add_resource(getLeadDetail, "/detail/<string:lead_uuid>")

if __name__ == "__main__":
    app.run(debug=True)

