// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract CertificateIssuer {
    address public admin;
    uint256 public certificateCount;
    
    struct Certificate {
        uint256 id;
        string studentName;
        string courseName;
        string institution;
        uint256 issueDate;
        bool isValid;
    }
    
    mapping(uint256 => Certificate) public certificates;
    mapping(bytes32 => bool) public certificateHashes;
    
    event CertificateIssued(uint256 indexed id, string studentName, string courseName, string institution);
    event CertificateRevoked(uint256 indexed id);
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }
    
    constructor() {
        admin = msg.sender;
    }
    
    function issueCertificate(
        string memory _studentName, 
        string memory _courseName, 
        string memory _institution
    ) external onlyAdmin {
        certificateCount++;
        uint256 issueDate = block.timestamp;
        bytes32 certHash = keccak256(abi.encodePacked(_studentName, _courseName, _institution, issueDate));
        require(!certificateHashes[certHash], "Certificate already exists");
        
        certificates[certificateCount] = Certificate(certificateCount, _studentName, _courseName, _institution, issueDate, true);
        certificateHashes[certHash] = true;
        
        emit CertificateIssued(certificateCount, _studentName, _courseName, _institution);
    }
    
    function revokeCertificate(uint256 _id) external onlyAdmin {
        require(certificates[_id].isValid, "Certificate is already revoked");
        certificates[_id].isValid = false;
        emit CertificateRevoked(_id);
    }
    
    function verifyCertificate(uint256 _id) external view returns (Certificate memory) {
        require(certificates[_id].isValid, "Certificate is not valid");
        return certificates[_id];
    }
}
