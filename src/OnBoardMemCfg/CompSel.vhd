------------------------------------------------------------------------
--  CompSel.vhd -- Component Selector
------------------------------------------------------------------------
--  Author : Mircea Dabacan
--           Copyright 2004 Digilent, Inc.
------------------------------------------------------------------------
-- Software version: Xilinx ISE 6.2.03i
--                   WebPack
------------------------------------------------------------------------
-- This file decodes regEppAdrIn 
-- to generate "SELECT" signals named CS0_7, CS80_9F, CS8_F, CS10, CSB0. 
-- 	CS0_7 	is active (HIGH) whenever regEppAdrIn = "00000xxx".
--
-- The selected component is assigned to the address range 0 to 7.
-- CompSel.vhd can be enhanced to select multiple components, 
-- with various address ranges assigned.
------------------------------------------------------------------------

-- Revision History:
-- 	10/21/2004(MirceaD): created
--		08/15/2007(TudorC):	added extra signals for the Nexys2 BIST (Xilinx ISE 9.2i)
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CompSel is
    Port (regEppAdrIn : in std_logic_vector(7 downto 0);
          CS0_7 : out std_logic
			 );
end CompSel;

architecture Behavioral of CompSel is

begin

 CS0_7 <= '1' when regEppAdrIn(7 downto 3) = "00000" else '0';

end Behavioral;

