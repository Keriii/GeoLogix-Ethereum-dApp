import React from 'react';

const Location = (lat,lon) => {
    const NodeGeocoder = require('node-geocoder');


    var options = {
        provider: 'google',
        httpAdapter: 'https', // Default
        apiKey: ' ', // for Mapquest, OpenCage, Google Premier
        formatter: 'json' // 'gpx', 'string', ...
    };

    var geocoder = NodeGeocoder(options);

    geocoder.reverse({ lat: lat, lon: lon }, function (err, res) {
        console.log(res);
    });
}

export default Location