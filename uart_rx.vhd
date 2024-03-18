----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2024 05:29:27 PM
-- Design Name: 
-- Module Name: uart_rx - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_rx is
    Port ( clk, en, rst, send : in STD_LOGIC;
           tx, ready : out STD_LOGIC;
           char : in STD_LOGIC_VECTOR (7 downto 0));
end uart_rx;

architecture Behavioral of uart_rx is
type state_type is (idle, start, data);
signal PS, NS :state_type; 

signal word :std_logic_vector (7 downto 0) := (others => '0');
signal count :std_logic_vector( 2 downto 0) := (others => '0');
begin

nstate_Logic: process(clk) 
begin 

    if( rising_edge(clk) and rst = '0') then 
        PS <= NS;
    elsif( rising_edge(clk) and rst = '1') then 
        NS <= Idle;
        word <= (others=> '0');
        count <= (others=> '0');
    end if;
    
end process; 

other: process(clk) 
begin 
    if(rising_edge(clk) and en = '1') then 
        
        case(PS) is 
        when data =>
        ready <= '0';
        word <= char;
        
        
        
        when start =>
        NS <= data; 
            
        
        when idle =>
        ready <= '1';
            if( send = '1') then 
                NS <= start;
            else 
                NS <= idle; 
            end if; 
        
        end case;
        
    end if; 

end process; 

end Behavioral;
