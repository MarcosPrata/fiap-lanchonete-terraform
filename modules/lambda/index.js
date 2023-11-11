const handler = async (event) => {
    let response = {
        "isAuthorized": false,
        "context": {
            "stringKey": "value",
            "numberKey": 1,
            "booleanKey": true,
            "arrayKey": ["value1", "value2"],
            "mapKey": { "value1": "value2" }
        }
    };

    // if (event.headers.cpf === "000.000.000-00") {
    //     response = {
    //         "isAuthorized": true,
    //         "context": {
    //             "stringKey": "value",
    //             "numberKey": 1,
    //             "booleanKey": true,
    //             "arrayKey": ["value1", "value2"],
    //             "mapKey": { "value1": "value2" }
    //         }
    //     };
    // }

    return response;
};

module.exports = { handler };