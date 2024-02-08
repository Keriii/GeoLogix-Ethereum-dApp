pragma solidity >=0.4.25 <8.0.0;

contract RefrigeratedTransportation
{
    //Set of States
    enum StateType { Created, Completed, OutOfCompliance}
    enum SensorType { None, deivceLongitude, Latitude, deviceTimestamp}

    //List of properties
    StateType public  State;
    address public  Owner;
    address public  Driver;
    address public  Device;
    address public  Contracts;
    int public  Latitude;
    int public  Longtude;
    int public  Radius;
    SensorType public  ComplianceSensorType;
    int public  ComplianceSensorReading;
    bool public  ComplianceStatus;
    string public  ComplianceDetail;

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

    // function TransferResponsibility(address newCounterparty) public
    // {
    //     // keep the state checking, message sender, and device checks separate
    //     // to not get cloberred by the order of evaluation for logical OR
    //     if ( State == StateType.Completed )
    //     {
    //         revert();
    //     }

    //     if ( State == StateType.OutOfCompliance )
    //     {
    //         revert();
    //     }

    //     if ( InitiatingCounterparty != msg.sender && Counterparty != msg.sender )
    //     {
    //         revert();
    //     }

    //     if ( newCounterparty == Device )
    //     {
    //         revert();
    //     }

    //     if (State == StateType.Created)
    //     {
    //         State = StateType.InTransit;
    //     }

    //     PreviousCounterparty = Counterparty;
    //     Counterparty = newCounterparty;
    // }

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