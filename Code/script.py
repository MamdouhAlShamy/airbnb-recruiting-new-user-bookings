
def isIdExistInSessions(id, src):
	with open(src) as f:
		for line in f:
			# sessionUser = line.split(",")[0]
			if id in line:
				return True

def waiting():
	with open(src) as f:
		for line in f:
			sessionUser = line.split(",")[0]
			print(sessionUser)

def readIds(src):
	with open(src) as f:
		lines = f.read().splitlines()
	return lines

if __name__ == "__main__":

	# Get Ids
	idSrc = "Data/Raw/Train_UserId.csv"
	idList = readIds(idSrc)
	# idList = ["d1mm9tcy42"]
	

	SessionSrc = "Data/Raw/sessions.csv"
	for id in idList:
		res	= isIdExistInSessions(id, SessionSrc)
		print(str(id) + ", " + str(res))
