import React from 'react'
import { Link } from 'react-router-dom';

const Lister = (props) => {

    let employees = props.employees;

    const listEmployees = () => {
        const employeeList = [...employees].map((e, i) => {

            return <li><b>Employee:</b> <Link to={`/empDetail/${i}`}> {e.name} </Link> | <b>Allowed Dist:</b>{e.distance} | <b>Has Obeyed:</b> {e.comply ? "Yes" : "No"}</li>

        })

        return employeeList;
    }

    return (
        <main>
            <div className="head">
                <h3>Employee list</h3>
                <h4><Link to={"/addEmp"} className="button">Add Employee</Link></h4>
            </div>
            <hr />
            <ol className="gradient-list">

                {listEmployees()}

            </ol>
        </main>
    )
}

export default Lister