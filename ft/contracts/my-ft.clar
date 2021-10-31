;; Implement the `ft-trait` trait defined in the `ft-trait` contract
(impl-trait .ft-trait.sip-010-trait)

(define-fungible-token CBFT)

;; get the token balance of owner
(define-read-only (get-balance (owner principal))
  (begin
    (ok (ft-get-balance CBFT owner))))

;; returns the total number of tokens
(define-read-only (get-total-supply)
  (ok (ft-get-supply CBFT)))

;; returns the token name
(define-read-only (get-name)
  (ok "Example Token"))

;; the symbol or "ticker" for this token
(define-read-only (get-symbol)
  (ok "EXAMPLE"))

;; the number of decimals used
(define-read-only (get-decimals)
  (ok u8))

;; Transfers tokens to a recipient
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
  (if (is-eq tx-sender sender)
    (begin
      (try! (ft-transfer? CBFT amount sender recipient))
      (print memo)
      (ok true)
    )
    (err u4)))

(define-public (get-token-uri)
  (ok (some "https://docs.stacks.co")))

;; Mint this token to a few people when deployed
(ft-mint? CBFT u100000000000000 'SP3NGY4DB4GWMGTFMVYRCJ5NPG1G3HVN54C4BGWRS)
(ft-mint? CBFT u100000000000000 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
(ft-mint? CBFT u12345 'ST50GEWRE7W5B02G3J3K19GNDDAPC3XPZPYQRQDW)