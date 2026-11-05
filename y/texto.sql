-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 05/11/2026 às 01:42
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
-- Banco de dados: `texto`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `receber`
--

CREATE TABLE `receber` (
  `id` int(11) NOT NULL,
  `texto` varchar(255) NOT NULL,
  `imagem` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `receber`
--

INSERT INTO `receber` (`id`, `texto`, `imagem`) VALUES
(1, 'teste', NULL),
(2, 'teste de texto ', NULL),
(3, 'teste emulador', NULL),
(9, 'ff', NULL),
(10, 'oi teste', NULL),
(11, 'emulasdor', NULL),
(12, 'imagem', 'fotos/1793838112_papel_parede_01_1066_768.jpg'),
(13, 'imagens teste', 'fotos/1793838434_f1ef4e0a-d731-46a2-9569-b7646e2b492f1291398563692435735.jpg'),
(14, '', 'fotos/1793838448_41bcb245-89a9-426c-947b-5fcf4aeb20218431414090071747099.jpg'),
(16, '', 'fotos/1793838729_dd68ef78-5a2a-4d78-9a07-5203680ed00c8872496569814354910.jpg'),
(17, '', 'fotos/1793838936_06666228-144e-4e3d-88e3-3f8b17b38c60811846888772774952.jpg'),
(18, '', ''),
(19, 'oi', 'fotos/1793839304_84b607e2-db1c-4232-939e-e912980fe5656246636012986686277.jpg');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `receber`
--
ALTER TABLE `receber`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `receber`
--
ALTER TABLE `receber`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
