# sBTC Clarity Contract

This repository contains the `sBTC` Clarity contract designed to facilitate the conversion of BTC to sBTC, manage liquidity, and support atomic swaps. The contract includes features for wrapping and unwrapping BTC, adding and claiming liquidity rewards, and providing time-locked recovery options for users.

The contract is designed to support a decentralized sBTC token ecosystem, allowing for secure transactions and liquidity management.

---

## Features

- **Wrap and Unwrap BTC**: 
  - Convert BTC to sBTC and vice versa with defined conversion rates.
  
- **Atomic Swap**: 
  - Swap STX for sBTC, enabling seamless conversion between STX and BTC-backed tokens.
  
- **Liquidity Management**:
  - Add liquidity to the sBTC pool and earn rewards calculated based on the liquidity provided.
  - Claim rewards for liquidity providers.
  
- **Time-Locked Recovery**: 
  - Recovery process with a time lock to ensure security for the recovery actions.

- **Dynamic Rate Adjustment**: 
  - Allows the contract owner to adjust the BTC-to-sBTC and STX-to-sBTC conversion rates to reflect market changes.

---

## Contract Functions

### 1. **Wrap BTC to sBTC**
Converts a specified amount of BTC into sBTC at the current conversion rate.

```clarity
(define-public (wrap-btc (btc-amount uint))
```

**Parameters**:
- `btc-amount`: The amount of BTC to convert.

**Returns**:
- A wrapped sBTC amount, or an error if the amount is not positive.

---

### 2. **Unwrap sBTC to BTC**
Converts a specified amount of sBTC back to BTC at the current conversion rate.

```clarity
(define-public (unwrap-sbtc (sBTC-amount uint))
```

**Parameters**:
- `sBTC-amount`: The amount of sBTC to convert.

**Returns**:
- The unwrapped BTC amount, or an error if the amount is not positive.

---

### 3. **Atomic Swap**
Performs an atomic swap between STX and BTC by converting STX into sBTC.

```clarity
(define-public (atomic-swap (stx-amount uint) (btc-amount uint))
```

**Parameters**:
- `stx-amount`: The amount of STX to swap.
- `btc-amount`: The amount of BTC to receive.

**Returns**:
- The swapped STX and BTC amounts, and the equivalent sBTC amount.

---

### 4. **Add Liquidity**
Allows liquidity providers to add liquidity to the sBTC pool and earn rewards.

```clarity
(define-public (add-liquidity (liquidity uint))
```

**Parameters**:
- `liquidity`: The amount of liquidity to add.

**Returns**:
- The updated liquidity pool and the added reward.

---

### 5. **Claim Reward**
Allows liquidity providers to claim rewards based on their liquidity contributions.

```clarity
(define-public (claim-reward (provider-id uint))
```

**Parameters**:
- `provider-id`: The ID of the liquidity provider.

**Returns**:
- The claimed reward for the liquidity provider.

---

### 6. **Time-Locked Recovery**
Initiates a recovery process that is locked until the specified unlock time.

```clarity
(define-public (time-locked-recovery (recovery-id uint))
```

**Parameters**:
- `recovery-id`: A unique identifier for the recovery process.

**Returns**:
- The recovery process for the given ID or an error if invalid.

---

### 7. **Adjust Conversion Rates**
Allows the contract owner to adjust the BTC-to-sBTC and STX-to-sBTC conversion rates.

```clarity
(define-public (adjust-btc-to-sBTC-rate (new-rate uint))
(define-public (adjust-stx-to-sBTC-rate (new-rate uint))
```

**Parameters**:
- `new-rate`: The new conversion rate to set.

**Returns**:
- A success message or an error if the rate is invalid.

---

## Getting Started

### Prerequisites

- **Clarity Language**: Ensure you are familiar with the Clarity language used for smart contracts on the Stacks blockchain.
- **Stacks Network**: This contract interacts with the Stacks blockchain. Make sure you have access to a Stacks node or an appropriate environment like the Stacks testnet or mainnet.
  
### Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/sBTC.git
   cd sBTC
   ```

2. **Deploy the contract**:
   Use the Stacks CLI or a compatible Stacks IDE (like Clarinet or ClarityHub) to deploy the contract to the Stacks network.

   ```bash
   stacks-cli deploy --contract sBTC.clar
   ```

3. **Interact with the contract**:
   Once deployed, you can interact with the contract through the Stacks CLI, or a frontend interface (e.g., a React app with a Stacks wallet).

### Example Usage

#### Wrap BTC to sBTC

To convert BTC to sBTC:

```bash
clarity-cli call wrap-btc --args 1000
```

This will convert 1000 BTC to sBTC based on the current conversion rate.

#### Unwrap sBTC to BTC

To convert sBTC back to BTC:

```bash
clarity-cli call unwrap-sbtc --args 1000
```

This will convert 1000 sBTC to BTC.

#### Add Liquidity

To add liquidity and receive rewards:

```bash
clarity-cli call add-liquidity --args 5000
```

This will add 5000 units of liquidity to the sBTC pool and calculate the corresponding reward.

---

## Security Considerations

- Ensure that only the contract owner can adjust conversion rates and make sensitive changes.
- Liquidity rewards should be carefully managed to prevent misuse or exploitation by malicious actors.

---

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to your fork (`git push origin feature-branch`).
5. Submit a pull request.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
