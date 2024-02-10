pragma solidity  ^0.8.0;

import "@thirdweb-dev/contracts/extension/Ownable.sol";


contract Geoogix
{
    event Delivery(address indexed driverId, bool status);
    
    address payable public owner;

    struct Driver{
        address driverId;
        string driverName;
        string longitude;
        string latitude;
        // string expectedlatitude;
        // string expectedlongitude;
        // string differnece;
        uint radius;
        string timestamp;
        bool status;
    }
    //Set of States

    
    address payable public driver;

    constructor() payable {owner = payable(msg.sender);
    }
    
    struct Conditions {

        string driverName;
        string longitude;
        string latitude;
        string expectedlatitude;
        string expectedlongitude;
        string differnece;
        string timestamp;

    }

    struct Status {
        string status;
    }

    address[] public driverIds;

    function createDriver( address _driverId, string memory _driverName, string memory _longitude, string memory _latitude,  uint radius, uint timestamp) exteranl onlyownerP
    
    
    address public  OwnerId;
    address public  DriverId;
    address public  Device;
    address public  Contracts;
    int public  Latitude;
    int public  Longtude;
    int public  Radius;
    bool public  ComplianceStatus;

    constructor(address device, address owner, address contracts, address driver, int longitude, int latitude, int radius)
    {
        ComplianceStatus = true;
        ComplianceSensorReading = -1;
        Owner = msg.sender;
        Device = device;
        Driver = driver;
        Contracts = contracts;
        Latitude = latitude;
        Longtude = longitude;
        Radius = radius;
        State = StateType.Created;
        ComplianceDetail = "N/A";
    }

    function square(int x) public pure returns (int){
        return (x * x);
    }

    function ReadLocation(int latitude, int longitude, int timestamp) public
    {
        // Separately check for states and sender 
        // to avoid not checking for state when the sender is the device
        // because of the logical OR
        if ( State == StateType.Completed )
        {
            revert();
        }

        if ( State == StateType.OutOfCompliance )
        {
            revert();
        }

        if (Device != msg.sender)
        {
            revert();
        }

        bool Inbound = square(Latitude - latitude) + square(Longtude - longitude) <= square(Radius);

        if (Inbound == false)
        {
            ComplianceDetail = "Out of range.";
            ComplianceStatus = false;
        }

        if (ComplianceStatus == false)
        {
            State = StateType.OutOfCompliance;
        }
    }

    function Complete() public
    {
        // keep the state checking, message sender, and device checks separate
        // to not get cloberred by the order of evaluation for logical OR
        if ( State == StateType.Completed )
        {
            revert();
        }

        if ( State == StateType.OutOfCompliance )
        {
            revert();
        }

        if (Owner != msg.sender)
        {
            revert();
        }

        State = StateType.Completed;
        Driver = 0x0000000000000000000000000000000000000000;
    }
}