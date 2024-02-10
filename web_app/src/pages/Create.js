import web3 from '../interactors/web3';
import React, { useEffect, useState } from 'react'
import contract from '../interactors/payer';
import "./add.css"

const Create = () => {

    const [currentAccount, setcurrentAccount] = useState()
    useEffect(() => {
        async function onInit() {
            await window.ethereum.enable();
            const accounts = await web3.eth.getAccounts();
            // const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
            const account = accounts[0];
            // console.log(account)
            setcurrentAccount(account)
            window.ethereum.on('accountsChanged', function (accounts) {
                // Time to reload your interface with accounts[0]!
                setcurrentAccount(accounts[0])

                // console.log(accounts[0])
            });
        }

        onInit();


    }, [])


    const addEmployee = async (e) => {
        e.preventDefault()
        let address = document.querySelector("#address").value
        let name = document.querySelector("#name").value
        let distance = document.querySelector("#distance").value
        let location = document.querySelector("#loc").value
        let lat = location.split(',')[0]
        let lng = location.split(',')[1]
        let endDate = document.querySelector("#end").value
        let convertedDate = new Date(endDate)
        let timeStamp = convertedDate.getTime()
        try {
            let createEmployee = await contract.methods.addEmployee(address, name, parseInt(distance), parseInt(timeStamp), parseInt(lat), parseInt(lng)).send({ from:currentAccount})
            console.log(createEmployee);
            window.location = "/"
        } catch (error) {
            window.alert("Something went Wrong!")
            console.log(error);
        }
        // console.log(name, address, distance, lat, lng, endDate, timeStamp);
    }
    return (
        <div className="form-wrapper" onSubmit={addEmployee}>
            <h3 className="form-header">Add Employee</h3>
            <form className='employee-form' action="">
                <div className="input-wrapper">
                    <label htmlFor="address">Address</label>
                    <input type="text" id='address' />
                </div>

                <div className="input-wrapper">
                    <label htmlFor="name">Name</label>
                    <input type="text" id='name' />
                </div>

                <div className="input-wrapper">
                    <label htmlFor="distance">Allowed Distance</label>
                    <input type="text" id='distance' />
                </div>

                <div className="input-wrapper">
                    <label htmlFor="loc">Centre Location</label>
                    <input type="text" id='loc' placeholder='lat,lon' />
                </div>

                <div className="input-wrapper">
                    <label htmlFor="end">Contract End Date</label>
                    <input type="date" id='end' />
                </div>

                <input type="submit" className='submit' value={"Create"} />



            </form>

        </div>
    )
}

export default Create