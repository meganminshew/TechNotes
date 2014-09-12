import pymongo
import sys

# connnect to the db on standard port
connection = pymongo.MongoClient("mongodb://localhost")


# attach to db
db = connection.epicenter

def find_one(query):

    try:
        if(db.policies.find_one(query)):
            return 1
        else:
            return 0
    except:
        print "Unexpected error:" + sys.exc_info()[0]

 

def extract_submissions():
    print "extract_submissions"
    try:
        pols = db.homesite.find()
        for doc in pols:
            pol = {}
            pol["policy_number"] = doc["policy_number"]
            pol["policy_module"] = doc["policy_module"]
            pol_key = doc["policy_number"] + '_' + doc["policy_module"]
            pol["policy_key"] = pol_key

            if "policy_expiration_date" in doc:
                pol["policy_expiration_date"] = doc["policy_expiration_date"]
            else:
                pol["policy_expiration_date"] = "9999-12-31"
            query = {'policy_key': pol_key}

            if(find_one(query) == 0):
                print "adding", pol_key
                db.policies.insert(pol)
    except:
        print "Unexpected error:" + sys.exc_info()[0]

 

extract_submissions()
