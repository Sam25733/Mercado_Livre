-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 19/11/2026 às 16:10
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `mercado_livre_ta_ops`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `candidatos`
--

CREATE TABLE `candidatos` (
  `id_candidato` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `estado` char(2) DEFAULT NULL,
  `consentimento_dados` tinyint(1) DEFAULT 0,
  `data_cadastro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `eventos`
--

CREATE TABLE `eventos` (
  `id_evento` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `descrcao` text DEFAULT NULL,
  `id_local` int(11) NOT NULL,
  `id_responsavel` int(11) DEFAULT NULL,
  `data_inicio` datetime NOT NULL,
  `data_fim` datetime DEFAULT NULL,
  `quantidade_vagas` int(11) NOT NULL DEFAULT 0,
  `STATUS` enum('PLANEJADO','CONFIRMADO','EM_ANDAMENTO','REALIZADO','CANCELADO') NOT NULL DEFAULT 'PLANEJADO',
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_atualizacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `evento_parceiros`
--

CREATE TABLE `evento_parceiros` (
  `id_evento` int(11) NOT NULL,
  `id_parceiro` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `leads`
--

CREATE TABLE `leads` (
  `id_lead` int(11) NOT NULL,
  `id_candidato` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL,
  `STATUS` enum('NOVO','EM_CONTATO','EM_PROCESSO','CONTRATADO','DESCARTADO') DEFAULT 'NOVO',
  `data_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `locais`
--

CREATE TABLE `locais` (
  `id_local` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `estado` char(2) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `id_regiao` int(11) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `localizcoes_veiculos`
--

CREATE TABLE `localizcoes_veiculos` (
  `id_localizacao` bigint(20) NOT NULL,
  `id_veiculo` int(11) NOT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `velocidade` decimal(6,2) DEFAULT 0.00,
  `data_hora_gps` datetime NOT NULL,
  `recebido_em` timestamp NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `motoristas`
--

CREATE TABLE `motoristas` (
  `id_motorista` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `status` enum('ATIVO','INATIVO') DEFAULT 'ATIVO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `parceiros`
--

CREATE TABLE `parceiros` (
  `id_parceiro` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `tipo` varchar(80) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `STATUS` enum('ATIVO','INATIVO') DEFAULT 'ATIVO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `perfis`
--

CREATE TABLE `perfis` (
  `id_perfil` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pontos_embarque`
--

CREATE TABLE `pontos_embarque` (
  `id_ponto` int(11) NOT NULL,
  `id_rota` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `horario` time DEFAULT NULL,
  `ordem` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `regioes`
--

CREATE TABLE `regioes` (
  `id_regiao` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `estado` char(2) NOT NULL,
  `pais` varchar(50) DEFAULT 'Brasil',
  `STATUS` enum('ATIVA','INATIVA') DEFAULT 'ATIVA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `rotas`
--

CREATE TABLE `rotas` (
  `id_rota` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `id_veiculo` int(11) NOT NULL,
  `id_motorista` int(11) NOT NULL,
  `id_regiao` int(11) DEFAULT NULL,
  `origem` varchar(150) DEFAULT NULL,
  `destino` varchar(150) DEFAULT NULL,
  `horario_saida` datetime DEFAULT NULL,
  `STATUS` enum('PLANEJADA','EM_ANDAMENTO','CONCLUIDA','CANCELADA') DEFAULT 'PLANEJADA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `senha_hash` varchar(255) NOT NULL,
  `id_perfil` int(11) NOT NULL,
  `STATUS` enum('ATIVO','INATIVO') DEFAULT 'ATIVO',
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_atualizacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `veiculos`
--

CREATE TABLE `veiculos` (
  `id_veiculo` int(11) NOT NULL,
  `codigo` varchar(30) NOT NULL,
  `placa` varchar(10) DEFAULT NULL,
  `modelo` varchar(100) DEFAULT NULL,
  `tipo` enum('FRETADO','VAN','ONIBUS','CARRO','OUTRO') NOT NULL,
  `capacidade` int(11) DEFAULT NULL,
  `id_regiao` int(11) DEFAULT NULL,
  `STATUS` enum('ATIVO','INATIVO','MANUTENCAO') DEFAULT 'ATIVO'
) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `candidatos`
--
ALTER TABLE `candidatos`
  ADD PRIMARY KEY (`id_candidato`);

--
-- Índices de tabela `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`id_evento`),
  ADD KEY `fk_eventos_responsavel` (`id_responsavel`),
  ADD KEY `idx_eventos_data` (`data_inicio`),
  ADD KEY `idx_eventos_status` (`STATUS`),
  ADD KEY `idx_eventos_local` (`id_local`);

--
-- Índices de tabela `evento_parceiros`
--
ALTER TABLE `evento_parceiros`
  ADD PRIMARY KEY (`id_evento`,`id_parceiro`),
  ADD KEY `id_parceiro` (`id_parceiro`);

--
-- Índices de tabela `leads`
--
ALTER TABLE `leads`
  ADD PRIMARY KEY (`id_lead`),
  ADD UNIQUE KEY `id_candidato` (`id_candidato`,`id_evento`),
  ADD KEY `id_evento` (`id_evento`);

--
-- Índices de tabela `locais`
--
ALTER TABLE `locais`
  ADD PRIMARY KEY (`id_local`),
  ADD KEY `id_regiao` (`id_regiao`);

--
-- Índices de tabela `localizcoes_veiculos`
--
ALTER TABLE `localizcoes_veiculos`
  ADD PRIMARY KEY (`id_localizacao`),
  ADD KEY `idx_veiculo_data` (`id_veiculo`,`data_hora_gps`);

--
-- Índices de tabela `motoristas`
--
ALTER TABLE `motoristas`
  ADD PRIMARY KEY (`id_motorista`);

--
-- Índices de tabela `parceiros`
--
ALTER TABLE `parceiros`
  ADD PRIMARY KEY (`id_parceiro`);

--
-- Índices de tabela `perfis`
--
ALTER TABLE `perfis`
  ADD PRIMARY KEY (`id_perfil`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Índices de tabela `pontos_embarque`
--
ALTER TABLE `pontos_embarque`
  ADD PRIMARY KEY (`id_ponto`),
  ADD UNIQUE KEY `id_rota` (`id_rota`,`ordem`);

--
-- Índices de tabela `regioes`
--
ALTER TABLE `regioes`
  ADD PRIMARY KEY (`id_regiao`);

--
-- Índices de tabela `rotas`
--
ALTER TABLE `rotas`
  ADD PRIMARY KEY (`id_rota`),
  ADD KEY `id_veiculo` (`id_veiculo`),
  ADD KEY `id_motorista` (`id_motorista`),
  ADD KEY `id_regiao` (`id_regiao`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_perfil` (`id_perfil`);

--
-- Índices de tabela `veiculos`
--
ALTER TABLE `veiculos`
  ADD PRIMARY KEY (`id_veiculo`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD UNIQUE KEY `placa` (`placa`),
  ADD KEY `id_regiao` (`id_regiao`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `candidatos`
--
ALTER TABLE `candidatos`
  MODIFY `id_candidato` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `eventos`
--
ALTER TABLE `eventos`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `leads`
--
ALTER TABLE `leads`
  MODIFY `id_lead` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `locais`
--
ALTER TABLE `locais`
  MODIFY `id_local` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `localizcoes_veiculos`
--
ALTER TABLE `localizcoes_veiculos`
  MODIFY `id_localizacao` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `motoristas`
--
ALTER TABLE `motoristas`
  MODIFY `id_motorista` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `parceiros`
--
ALTER TABLE `parceiros`
  MODIFY `id_parceiro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `perfis`
--
ALTER TABLE `perfis`
  MODIFY `id_perfil` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pontos_embarque`
--
ALTER TABLE `pontos_embarque`
  MODIFY `id_ponto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `regioes`
--
ALTER TABLE `regioes`
  MODIFY `id_regiao` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `rotas`
--
ALTER TABLE `rotas`
  MODIFY `id_rota` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `veiculos`
--
ALTER TABLE `veiculos`
  MODIFY `id_veiculo` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `eventos`
--
ALTER TABLE `eventos`
  ADD CONSTRAINT `fk_eventos_locais` FOREIGN KEY (`id_local`) REFERENCES `locais` (`id_local`),
  ADD CONSTRAINT `fk_eventos_responsavel` FOREIGN KEY (`id_responsavel`) REFERENCES `usuarios` (`id_usuario`);

--
-- Restrições para tabelas `evento_parceiros`
--
ALTER TABLE `evento_parceiros`
  ADD CONSTRAINT `evento_parceiros_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `eventos` (`id_evento`),
  ADD CONSTRAINT `evento_parceiros_ibfk_2` FOREIGN KEY (`id_parceiro`) REFERENCES `parceiros` (`id_parceiro`);

--
-- Restrições para tabelas `leads`
--
ALTER TABLE `leads`
  ADD CONSTRAINT `leads_ibfk_1` FOREIGN KEY (`id_candidato`) REFERENCES `candidatos` (`id_candidato`),
  ADD CONSTRAINT `leads_ibfk_2` FOREIGN KEY (`id_evento`) REFERENCES `eventos` (`id_evento`);

--
-- Restrições para tabelas `locais`
--
ALTER TABLE `locais`
  ADD CONSTRAINT `locais_ibfk_1` FOREIGN KEY (`id_regiao`) REFERENCES `regioes` (`id_regiao`);

--
-- Restrições para tabelas `localizcoes_veiculos`
--
ALTER TABLE `localizcoes_veiculos`
  ADD CONSTRAINT `localizcoes_veiculos_ibfk_1` FOREIGN KEY (`id_veiculo`) REFERENCES `veiculos` (`id_veiculo`);

--
-- Restrições para tabelas `pontos_embarque`
--
ALTER TABLE `pontos_embarque`
  ADD CONSTRAINT `pontos_embarque_ibfk_1` FOREIGN KEY (`id_rota`) REFERENCES `rotas` (`id_rota`);

--
-- Restrições para tabelas `rotas`
--
ALTER TABLE `rotas`
  ADD CONSTRAINT `rotas_ibfk_1` FOREIGN KEY (`id_veiculo`) REFERENCES `veiculos` (`id_veiculo`),
  ADD CONSTRAINT `rotas_ibfk_2` FOREIGN KEY (`id_motorista`) REFERENCES `motoristas` (`id_motorista`),
  ADD CONSTRAINT `rotas_ibfk_3` FOREIGN KEY (`id_regiao`) REFERENCES `regioes` (`id_regiao`);

--
-- Restrições para tabelas `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_perfil`) REFERENCES `perfis` (`id_perfil`);

--
-- Restrições para tabelas `veiculos`
--
ALTER TABLE `veiculos`
  ADD CONSTRAINT `veiculos_ibfk_1` FOREIGN KEY (`id_regiao`) REFERENCES `regioes` (`id_regiao`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
