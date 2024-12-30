(define-data-var sBTC-price uint 0)
(define-data-var sBTC-liquidity uint 0)
(define-data-var btc-to-sBTC-rate uint 1000)

(begin
  (print "sBTC Enhancements Initialized")
)
(define-data-var sBTC-price uint 0)             ;; Variable to store the price of sBTC.
(define-data-var sBTC-liquidity uint 0)         ;; Tracks the total liquidity in the sBTC pool.
(define-data-var btc-to-sBTC-rate uint 1000)    ;; Conversion rate from BTC to sBTC (1 BTC = 1000 sBTC).
(define-data-var stx-to-sBTC-rate uint 50)      ;; Conversion rate from STX to sBTC (1 STX = 50 sBTC).
(define-data-var liquidity-rewards uint 0)      ;; Total rewards available for liquidity providers.

(begin
  (print "sBTC Enhancements - Phase 2 Initialized") ;; Output a log when the contract is initialized.
)

;; Function to check if the given amount is valid (greater than 0)
;; This line might have been wrongly written as `define`.
(define-data-var sBTC-price uint 0)

  (if (> amount u0)
      (ok amount)
      (err u1))

;; Wrap BTC into sBTC
(define-public (wrap-btc (btc-amount uint))
  (match (check-positive btc-amount) ;; Validate BTC amount.
    (err e) (err e) ;; Return error if invalid amount.
    (ok valid-btc-amount) ;; Continue if valid.
      (let ((sBTC-amount (mul valid-btc-amount (var-get btc-to-sBTC-rate)))) ;; Convert BTC to sBTC.
        (ok { "wrapped-amount": sBTC-amount })) ;; Return wrapped amount.
))

;; Unwrap sBTC into BTC
(define-public (unwrap-sbtc (sBTC-amount uint))
  (match (check-positive sBTC-amount) ;; Validate sBTC amount.
    (err e) (err e) ;; Return error if invalid amount.
    (ok valid-sBTC-amount) ;; Continue if valid.
      (let ((btc-amount (/ valid-sBTC-amount (var-get btc-to-sBTC-rate)))) ;; Convert sBTC to BTC.
        (ok { "unwrapped-amount": btc-amount })) ;; Return unwrapped amount.
))

;; Atomic swap between STX and BTC
(define-public (atomic-swap (stx-amount uint) (btc-amount uint))
  (match (check-positive stx-amount) ;; Validate STX amount.
    (err e) (err e) ;; Return error if invalid STX amount.
    (ok valid-stx-amount) ;; Continue if valid.
      (match (check-positive btc-amount) ;; Validate BTC amount.
        (err e) (err e) ;; Return error if invalid BTC amount.
        (ok valid-btc-amount) ;; Continue if valid.
          (let ((sBTC-amount (mul valid-stx-amount (var-get stx-to-sBTC-rate)))) ;; Convert STX to sBTC.
            (ok { "swapped-stx": valid-stx-amount, "swapped-btc": valid-btc-amount, "converted-sBTC": sBTC-amount })) ;; Return results.
)))

;; Time-locked recovery using recovery ID
(define-public (time-locked-recovery (recovery-id uint) (unlock-time uint))
  (if (and (> recovery-id u0) (> unlock-time u0)) ;; Ensure both recovery ID and unlock time are valid.
      (begin
        (let ((current-time (block-height))) ;; Get the current block height.
          (if (>= current-time unlock-time) ;; Check if the current block height is past the unlock time.
              (ok { "recovery-id": recovery-id, "status": "recovery unlocked" })
              (ok { "recovery-id": recovery-id, "status": "locked, wait for unlock time" }))))
      (err u1) ;; Error if recovery ID or unlock time is invalid.
))

;; Add liquidity to the sBTC pool and reward liquidity providers
(define-public (add-liquidity (liquidity uint))
  (match (check-positive liquidity) ;; Validate liquidity amount.
    (err e) (err e) ;; Return error if invalid liquidity.
    (ok valid-liquidity) ;; Continue if valid.
      (begin
        (var-set sBTC-liquidity (+ (var-get sBTC-liquidity) valid-liquidity)) ;; Update liquidity pool.
        (let ((reward (/ valid-liquidity u10))) ;; Calculate rewards (10% of the liquidity).
          (var-set liquidity-rewards (+ (var-get liquidity-rewards) reward)) ;; Update rewards.
          (ok { "new-liquidity": (var-get sBTC-liquidity), "reward-added": reward })))) ;; Return updated liquidity and rewards.
)

;; Claim rewards for liquidity providers
(define-public (claim-reward (provider-id uint))
  (if (> provider-id u0)  ;; Ensure provider ID is valid (greater than 0).
      (begin
        (let ((reward (var-get liquidity-rewards)))  ;; Get the total rewards.
        (if (> reward u0) ;; Ensure rewards are greater than 0.
            (begin
              (var-set liquidity-rewards u0)  ;; Reset rewards after claim.
              (ok { "reward-for": provider-id, "reward-amount": reward })) ;; Return the claimed rewards.
            (err u2))) ;; Error if no rewards available.
      (err u1) ;; Error if provider ID is invalid.
))

;; Function to dynamically adjust sBTC conversion rate
(define-public (adjust-btc-to-sBTC-rate (new-rate uint))
  (if (> new-rate u0)  ;; Ensure the new rate is greater than 0.
      (begin
        (var-set btc-to-sBTC-rate new-rate)  ;; Update conversion rate.
        (ok { "new-btc-to-sBTC-rate": new-rate })) ;; Return updated rate.
      (err u1) ;; Error if the new rate is invalid.
))

;; Function to update STX-to-sBTC conversion rate
(define-public (adjust-stx-to-sBTC-rate (new-rate uint))
  (if (> new-rate u0)  ;; Ensure the new rate is greater than 0.
      (begin
        (var-set stx-to-sBTC-rate new-rate)  ;; Update conversion rate.
        (ok { "new-stx-to-sBTC-rate": new-rate })) ;; Return updated rate.
      (err u1) ;; Error if the new rate is invalid.
)))
