const fs = require('fs')
var Parsed = JSON.parse(
  `[
    {
        "ParameterKey": "MyAMIID",
        "ParameterValue": "ami-08c40ec9ead489470"
    },
    {
        "ParameterKey": "MyKeyPair",
        "ParameterValue": "green"
    },
    {
        "ParameterKey": "FiletoDownload",
        "ParameterValue": "DOWNLOAD_URL"
    },
    {
        "ParameterKey": "DBHost",
        "ParameterValue": "rdsstack-mydb-zwcjxfzooewl.cex6zldqmeqr.us-east-1.rds.amazonaws.com"
    },
    {
        "ParameterKey": "DBPASS",
        "ParameterValue": "mypass12345"
    },
    {
        "ParameterKey": "DBUSER",
        "ParameterValue": "myuser"
    }
]
`
)

Parsed[2].ParameterValue = process.argv[2]
Parsed[3].ParameterValue = process.argv[3]

fs.writeFile('./EC2/parameters.json', JSON.stringify(Parsed), (err) => {
  if (err) {
    console.error(err)
  }
  console.log('parameters updated')
})
