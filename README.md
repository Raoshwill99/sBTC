# Seamless Bitcoin-Stacks Interoperability (sBTC Enhancements)

This project enhances the usability and adoption of sBTC by automating key features, simplifying user interactions, and incentivizing liquidity provision. The smart contract, written in Clarity, integrates Bitcoin and Stacks seamlessly to position Stacks as a reliable Bitcoin Layer 2.

## Features

1. **Wrapping/Unwrapping BTC:**
   - Users can easily convert Bitcoin (BTC) to sBTC and vice versa with simple function calls.

2. **Atomic Swaps:**
   - Enable frictionless swaps between STX and BTC, laying the groundwork for a robust trading ecosystem.

3. **Incentives for Liquidity Providers:**
   - Liquidity providers can contribute to sBTC liquidity and claim rewards.

4. **Time-Locked Recovery:**
   - A security feature for safe handling of wrapping and unwrapping operations.

## Smart Contract Details

### Data Variables
- `sBTC-price`: Tracks the price of sBTC (currently set to `0` as a placeholder).
- `sBTC-liquidity`: Maintains the total liquidity of sBTC in the system.
- `btc-to-sBTC-rate`: Conversion rate from BTC to sBTC (default: `1 BTC = 1000 sBTC`).

### Public Functions

#### `wrap-btc (btc-amount uint)`
Converts a specified amount of BTC into sBTC based on the current conversion rate.

#### `unwrap-sbtc (sBTC-amount uint)`
Converts a specified amount of sBTC back into BTC.

#### `atomic-swap (stx-amount uint, btc-amount uint)`
Facilitates an atomic swap between specified amounts of STX and BTC.

#### `time-locked-recovery (recovery-id uint)`
Provides a mechanism for time-locked recovery operations.

#### `add-liquidity (liquidity uint)`
Allows liquidity providers to add to the sBTC pool, increasing its availability.

#### `claim-reward (provider-id uint)`
Enables liquidity providers to claim rewards based on their contributions.

## Setup and Deployment

1. Install the necessary dependencies for Clarity development.
2. Clone this repository and navigate to the project directory.
3. Deploy the smart contract on the Stacks blockchain using a local development environment or the Stacks Testnet.

## Usage

1. Call the relevant functions via a Clarity-compatible interface (e.g., Hiro Wallet, Stacks CLI, or custom dApps).
2. Monitor liquidity and rewards using the state variables and reward claiming functions.
3. Ensure valid inputs to prevent errors (e.g., values greater than `0`).

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request for review.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
