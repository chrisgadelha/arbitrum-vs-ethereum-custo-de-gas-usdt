-- Custo Médio de Envio de USDT na Ethereum (L1)


SELECT 
    DATE_TRUNC('day', t.block_time) AS dia,
    
    AVG((t.gas_used * t.gas_price / 1e18) * p.price) AS taxa_media_usd

FROM ethereum.transactions AS t
LEFT JOIN prices.usd AS p ON p.minute = DATE_TRUNC('minute', t.block_time)

WHERE 
    -- Endereço do contrato do USDT na Ethereum
    t.to = 0xdAC17F958D2ee523a2206206994597C13D831ec7 
    
   
    AND t.block_time >= TIMESTAMP '2025-10-01'
    AND t.block_time <= TIMESTAMP '2025-12-31'
    
    AND t.success = true

     AND p.blockchain = 'ethereum'
    AND p.symbol = 'WETH'

GROUP BY 1
ORDER BY 1 ASC
;
