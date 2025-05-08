// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title LoanDefaultRegistry
 * @dev A smart contract to store and manage loan default records on Ethereum.
 * Only the contract owner (e.g., SACCO officer) can add new defaults.
 */
contract LoanDefaultRegistry {
    
    // Struct to hold a loan default record
    struct DefaultRecord {
        uint id;
        string borrowerName;
        string registrationNumber;
        uint loanAmount;
        string reason;
        uint dateRecorded;
    }

    // Mapping of record ID to DefaultRecord
    mapping(uint => DefaultRecord) public defaults;
    uint public defaultCount;

    // Contract owner address (SACCO officer)
    address public owner;

    // Modifier to restrict function access
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not authorized to perform this action.");
        _;
    }

    // Event emitted when a new default record is added
    event DefaultAdded(
        uint id,
        string borrowerName,
        string registrationNumber,
        uint loanAmount,
        string reason,
        uint dateRecorded
    );

    // Constructor sets the contract deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Function to add a new default record
     * @param _borrowerName Name of the borrower
     * @param _registrationNumber Borrower's unique registration number
     * @param _loanAmount Amount of the defaulted loan (in wei or ETH depending on frontend)
     * @param _reason Reason for the loan default
     */
    function addDefault(
        string memory _borrowerName,
        string memory _registrationNumber,
        uint _loanAmount,
        string memory _reason
    ) public onlyOwner {
        defaultCount++;
        defaults[defaultCount] = DefaultRecord(
            defaultCount,
            _borrowerName,
            _registrationNumber,
            _loanAmount,
            _reason,
            block.timestamp
        );

        emit DefaultAdded(
            defaultCount,
            _borrowerName,
            _registrationNumber,
            _loanAmount,
            _reason,
            block.timestamp
        );
    }

    /**
     * @dev Function to get a default record by ID
     * @param _id ID of the default record
     * @return DefaultRecord struct
     */
    function getDefault(uint _id) public view returns (DefaultRecord memory) {
        require(_id > 0 && _id <= defaultCount, "Record not found.");
        return defaults[_id];
    }

    /**
     * @dev Returns the total number of default records stored.
     */
    function getTotalDefaults() public view returns (uint) {
        return defaultCount;
    }
}
