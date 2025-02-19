// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ScholarshipSystem {
    address public admin;
    uint256 public totalScholarships;

    struct Scholarship {
        uint256 id;
        string name;
        uint256 amount;
        address donor;
        address recipient;
        bool isFunded;
        bool isClaimed;
    }

    mapping(uint256 => Scholarship) public scholarships;
    mapping(address => bool) public students;

    event ScholarshipCreated(uint256 indexed id, string name, uint256 amount, address donor);
    event ScholarshipClaimed(uint256 indexed id, address recipient, uint256 amount);
    event StudentRegistered(address student);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier onlyUnclaimed(uint256 _id) {
        require(!scholarships[_id].isClaimed, "Scholarship already claimed");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function registerStudent(address _student) external onlyAdmin {
        students[_student] = true;
        emit StudentRegistered(_student);
    }

    function createScholarship(string memory _name, uint256 _amount) external payable {
        require(msg.value == _amount, "Sent amount must match the scholarship amount");
        totalScholarships++;
        scholarships[totalScholarships] = Scholarship(totalScholarships, _name, _amount, msg.sender, address(0), true, false);
        emit ScholarshipCreated(totalScholarships, _name, _amount, msg.sender);
    }

    function claimScholarship(uint256 _id) external onlyUnclaimed(_id) {
        require(students[msg.sender], "Only registered students can claim");
        scholarships[_id].recipient = msg.sender;
        scholarships[_id].isClaimed = true;
        payable(msg.sender).transfer(scholarships[_id].amount);
        emit ScholarshipClaimed(_id, msg.sender, scholarships[_id].amount);
    }

    function getScholarship(uint256 _id) external view returns (Scholarship memory) {
        return scholarships[_id];
    }
}
