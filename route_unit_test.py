import requests, time, sys
from detect import detect

command = "kubectl get service hotrod-frontend -o jsonpath='{.status.loadBalancer.ingress[0].ip}' -n "

"""
Checks that the server returns a valid response
"""
def test(host, port):
	response = requests.get("http://" + host + ":" + str(port) + "/route?dropoff=test&pickup=test2")
	assert response.status_code == 200, "Status code was {} instead of 200".format(response.status_code)
	result = response.json()
	assert result["Pickup"] == "test"
	assert result["Dropoff"] == "test2"
	assert isinstance(result["ETA"], int)

if __name__ == '__main__':

	test("hotrod-route", 8083)
