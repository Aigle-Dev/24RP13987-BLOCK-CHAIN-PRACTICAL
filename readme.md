# Loan Default Registry Smart Contract

This project is a blockchain-based loan default tracking system for Savings and Credit Cooperative Organizations (SACCOs). It allows SACCO officers to securely store, manage, and retrieve loan default records on the Ethereum blockchain.

## 📌 Overview

The `LoanDefaultRegistry` smart contract enables the SACCO to:
- Record loan defaults by member name and registration number.
- Log details such as loan amount, reason for default, and timestamp.
- Restrict access so only the contract owner (SACCO officer) can add new records.
- Retrieve individual default records and total defaults stored.

---

## 🛠️ Features

- Only the contract owner can add loan default entries.
- Public read access for transparency and accountability.
- Uses Solidity `^0.8.0` and can be deployed on any EVM-compatible blockchain.
- Emits an event on every record addition for frontend listening.

---

## 📄 Contract Details

### Struct: `DefaultRecord`
Stores the following fields:
- `id`: Unique identifier
- `borrowerName`: Name of the borrower
- `registrationNumber`: Member registration number
- `loanAmount`: Amount defaulted (in wei or ETH)
- `reason`: Reason for loan default
- `dateRecorded`: UNIX timestamp of record entry

### State Variables
- `mapping(uint => DefaultRecord) public defaults`: Stores all default records.
- `uint public defaultCount`: Tracks the number of records.
- `address public owner`: Address of the contract deployer (SACCO officer).

---

## 🔐 Access Control

Only the contract owner can call `addDefault()`.  
Ownership is set at deployment using the `constructor()`.

---

## ⚙️ Functions

### `constructor()`
Sets the deployer as the contract `owner`.

### `addDefault(string memory _borrowerName, string memory _registrationNumber, uint _loanAmount, string memory _reason)`
Adds a new loan default record. **Only callable by the owner**.

### `getDefault(uint _id) public view returns (DefaultRecord memory)`
Returns the default record with the specified ID.

### `getTotalDefaults() public view returns (uint)`
Returns the total number of loan default records.

---

## 📦 Events

### `event DefaultAdded(...)`
Emitted when a new default record is added. Useful for frontend apps to detect changes.

---

## 🧪 Deployment & Testing

You can deploy this contract using:
- [Remix IDE](https://remix.ethereum.org/)
- Hardhat or Truffle (for local and testnet deployment)

Make sure to:
1. Use a wallet like MetaMask.
2. Deploy to a testnet (e.g., Goerli or Sepolia) for testing.
3. Set `owner` permissions correctly.

---

## 🖼️ Example Use Case

A SACCO officer logs a default by entering the member's name, registration number, and loan info. The contract stores this on-chain. Later, auditors or the SACCO team can view the record with full confidence in its integrity.

---

## 📚 Project Structure

