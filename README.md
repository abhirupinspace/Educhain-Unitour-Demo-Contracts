# Educhain-Unitour-Demo-Contracts# **🔍 Smart Contract Debugging Guide**  

This guide provides common **Solidity smart contract errors**, how to **identify them**, and **debugging techniques** using **Remix IDE** and AI-powered tools.  

---

## **📌 1. General Debugging Steps**  

✅ **Use Remix IDE’s Debugger:** Inspect failed transactions under the **Debugger** tab.  
✅ **Check Solidity Compiler Warnings:** Fix warnings before deployment.  
✅ **Test with Hardhat or Foundry:** Run unit tests to catch logical errors.  
✅ **Use AI Assistance:** Ask ChatGPT or Copilot for debugging help.  

---

## **⚠️ 2. Common Solidity Errors & Fixes**  

### **1️⃣ Compiler Errors (`pragma` issues, `Missing Semicolon`)**  

🔴 **Error:** `ParserError: Expected ';' but got identifier`  
✅ **Fix:** Check for missing `;` at the end of lines.  

🔴 **Error:** `Source file requires different compiler version`  
✅ **Fix:** Ensure **pragma version** matches:  
```solidity
pragma solidity ^0.8.0;
```  

---

### **2️⃣ Out of Gas & Infinite Loops**  

🔴 **Error:** Transaction runs out of gas when calling a function.  
✅ **Fix:**  
- Avoid **unbounded loops** (e.g., `for (uint i = 0; i < users.length; i++)`).
- Use **mapping** instead of **arrays** for large datasets.  

---

### **3️⃣ Reentrancy Vulnerability**  

🔴 **Error:** Smart contract drained due to **reentrancy attack**.  
✅ **Fix:** Use the **Checks-Effects-Interactions** pattern:  
```solidity
function withdraw() public {
    uint amount = balances[msg.sender];
    balances[msg.sender] = 0;  // ✅ Update state before sending funds
    (bool success, ) = msg.sender.call{value: amount}("");
    require(success, "Transfer failed");
}
```

---

### **4️⃣ Unchecked External Call Errors**  

🔴 **Error:** Funds sent to a smart contract but not received.  
✅ **Fix:** Always check if `call()` was successful:  
```solidity
(bool success, ) = recipient.call{value: amount}("");
require(success, "Transfer failed");
```  

---

### **5️⃣ `require()` & `assert()` Failures**  

🔴 **Error:** `require` statement failing unexpectedly.  
✅ **Fix:** Ensure correct logic and error messages in `require()`:  
```solidity
require(msg.value > 0, "Must send ETH to donate");
```  

🔴 **Error:** `assert()` used incorrectly.  
✅ **Fix:** **Use `assert()` only for internal invariants**, not user input:  
```solidity
assert(owner != address(0));  // ✅ Ensures contract has an owner
```

---

### **6️⃣ Mismatched Storage & Memory Variables**  

🔴 **Error:** `TypeError: Data location must be "memory" or "calldata"`  
✅ **Fix:** Explicitly declare data location for reference types:  
```solidity
function setData(string memory _name) public {
    name = _name;
}
```

---

### **7️⃣ `SafeMath` Overflow & Underflow** (Solidity 0.8+ Handles This)  

🔴 **Error:** Integer overflows in older Solidity versions.  
✅ **Fix:** Use Solidity 0.8+ which has **built-in overflow checks** or use **SafeMath** in older versions.  

```solidity
// Solidity 0.8+ prevents overflows automatically
uint256 x = 255;
x += 1; // Will revert if it overflows
```

---

## **🛠️ 3. Debugging Tools**  

🔹 **Remix IDE Debugger** – Step through transactions.  
🔹 **Hardhat/Foundry Tests** – Run local test cases.  
🔹 **ChatGPT/Copilot** – AI-assisted debugging.  
🔹 **Etherscan & Tenderly** – Inspect deployed contract calls.  

---

## **🚀 4. Next Steps**  

✔ **Write Unit Tests** – Always test functions before deploying.  
✔ **Simulate Transactions** – Use Remix or Hardhat to predict failures.  
✔ **Audit Before Deployment** – Check for security flaws.  

📢 **Join EDU Chain Hackathon & Build Secure dApps!** 🚀  

🔗 [Register Here](https://www.hackquest.io/hackathons/EDU-Chain-Semester-3)  

---
