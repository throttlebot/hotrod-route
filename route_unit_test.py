import requests, sys

"""
Checks that the server returns a valid response
"""
def test(host, port):
	response = requests.get("http://" + host + ":" + str(port) + "/route?dropoff=test&pickup=test2")
	assert response.status_code == 200, "Status code was {} instead of 200".format(response.status_code)
	result = response.json()
	assert result["Pickup"] == "test2"
	assert result["Dropoff"] == "test"
	assert isinstance(result["ETA"], int)
	print "pass"
	print result

if __name__ == '__main__':

	test(sys.argv[1], 8083)
