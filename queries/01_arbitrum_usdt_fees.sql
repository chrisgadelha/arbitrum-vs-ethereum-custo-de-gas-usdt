-- Obter custo médio de envio de USDT na rede Arbitrum One nos últimos 90 do ano de 2025
-- Objetivo: comparar com taxas bancárias tradicionais o envio de USD x USDT

SELECT 
    DATE_TRUNC('day', t.block_time) AS dia,
    
    AVG((t.gas_used * t.effective_gas_price / 1e18) * p.price) AS taxa_paga_media

FROM arbitrum.transactions AS t
LEFT JOIN prices.usd AS p ON p.minute = DATE_TRUNC('minute', t.block_time)

WHERE 
    -- Endereço do contrato do USDT na Arbitrum One
    t.to = 0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9
    
    
    AND t.block_time >= TIMESTAMP '2025-10-01'
    AND t.block_time <= TIMESTAMP '2025-12-31'

    -- filtrar apenas transações com sucesso
    AND t.success = true

    -- preço do ETH na Arbitrum
    AND p.blockchain = 'arbitrum'
    AND p.symbol = 'WETH'

GROUP BY 1
ORDER BY 1 ASC
;
