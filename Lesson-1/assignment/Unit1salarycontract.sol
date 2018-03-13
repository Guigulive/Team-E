//Solidity version
pragma solidity ^0.4.14;

//Contract declaration
contract Payroll{
    
    //Define variables;
    uint salary;
    address administrator;
    address employee;
    uint constant payDuration = 10 seconds;
    uint lastPayday = now;
    
    //identification of the contract owner
    function employer () {
        administrator = msg.sender;
    }
    
    //Adjust or declare your employee's address
    function toEmployee(address switchEmployee) returns (address){
        require(msg.sender == administrator);
        employee = switchEmployee;
        return employee;
    }
    
    //Adjust or declare the salary of your employee
    function adjustSalary(uint newSalary) returns (uint){
        require(msg.sender == administrator);
        salary = newSalary * 1 ether;
        return salary;
    }
    
    //Add etherium fund into the contract
    function addFund() payable returns (uint) {
        return this.balance;
    }
    
    //Calculate how many times can be paid from your balance
    function calculateRunway() returns (uint) {
        return this.balance / salary;
    }
    
    //Calculate if your balance can afford the next payment
    function enoughFund() returns (bool) {
        return calculateRunway() > 0;
    }
    
    //Your employee can get paid from this function
    function getPaid() {
        if (msg.sender != employee) {
            revert();
        }
        
        uint nextPayday = lastPayday + payDuration;
        if (nextPayday > now) {
            revert();
        }
        
            lastPayday = nextPayday;
            employee.transfer(salary);
        }
    }
