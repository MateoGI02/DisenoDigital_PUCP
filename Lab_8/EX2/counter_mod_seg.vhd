Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_mod_seg is
  port (signal reset_n			:  in std_logic;
        signal clk     			:  in std_logic;
        signal en_seg 		   : in std_logic;
		  signal max_seg		   : out std_logic;
		   signal  dsec_p_dec  :out std_logic_vector(6 downto 0);
		   signal dsec_p_uni:out std_logic_vector(6 downto 0);
		   signal visualizador_q_segundos : out std_logic_vector(5 downto 0));
end counter_mod_seg;

architecture estructura of counter_mod_seg is

signal k,q : unsigned(5 downto 0);
signal q_interno,f : std_logic_vector(7 downto 0);
signal decenas,unidades : std_logic_vector(3 downto 0);


begin
			process(k,clk,en_seg,reset_n)
			begin
					if reset_n='0' then --g_reset_n en el llamado port map lo reemplaza
					q<=(others=>'0');
					elsif rising_edge(clk) then
							if en_seg='1' then
							q<=k;
							end if;
					end if;
			end process;

k<="011000" when q=0 else (q-1);					
max_seg <= '1' when q=0 else '0';

visualizador_q_segundos<=std_logic_vector(q);
--Transformar de binario a bcd por medio del hexadecimal
q_interno<="00"&std_logic_vector(q);

  with q_interno select
    f <= x"00" when x"00", -- 0000 0000  0000
         x"01" when x"01",--  0000 0001  0001
         x"02" when x"02",
         x"03" when x"03",
         x"04" when x"04",
         x"05" when x"05",
         x"06" when x"06",
         x"07" when x"07",
         x"08" when x"08",
         x"09" when x"09",			 
         x"10" when x"0A",
         x"11" when x"0b",
         x"12" when x"0C",
         x"13" when x"0d",
         x"14" when x"0E",
         x"15" when x"0F",
         x"16" when x"10",
         x"17" when x"11",		 
         x"18" when x"12",
         x"19" when x"13",
         x"20" when x"14",	
         x"21" when x"15",
         x"22" when x"16",		 
         x"23" when x"17",
         x"24" when x"18",
         x"25" when x"19",	
         x"26" when x"1A",
         x"27" when x"1b",		 
         x"28" when x"1C",
         x"29" when x"1d",
         x"30" when x"1E",	
         x"31" when x"1F",	 
         x"32" when x"20",
         x"33" when x"21",
         x"34" when x"22",
         x"35" when x"23",
         x"36" when x"24",
         x"37" when x"25",
         x"38" when x"26",
         x"39" when x"27",
         x"40" when x"28",
         x"41" when x"29",			 
         x"42" when x"2A",
         x"43" when x"2b",
         x"44" when x"2C",
         x"45" when x"2d",
         x"46" when x"2E",
         x"47" when x"2F",
         x"48" when x"30",
         x"49" when x"31",		 
         x"50" when x"32",
         x"51" when x"33",
         x"52" when x"34",	
         x"53" when x"35",
         x"54" when x"36",		 
         x"55" when x"37",
         x"56" when x"38",
         x"57" when x"39",	
         x"58" when x"3A",
         x"59" when x"3b",		 
          "--------" when others;
--separando en 4bits cada lado de la unidad y decena
decenas<=f(7 downto 4);
unidades<=f(3 downto 0);

---señales para el display 
with unidades select
dsec_p_uni <= "1000000" when x"0", --binario when hexadecimal
							"0110000" when x"1",
							"1101101" when x"2",
							"1111001" when x"3",
							"0110011" when x"4",
							"1011011" when x"5",
							"1011111" when x"6",
							"1110000" when x"7",
							"1111111" when x"8",
							"1111011" when x"9",	
										 
							"-------" when others;

			
with decenas select
dsec_p_dec   <= "1000000" when x"0", --binario when hexadecimal
							"0110000" when x"1",
							"1101101" when x"2",
							"1111001" when x"3",
							"0110011" when x"4",
							"1011011" when x"5",
							"1011111" when x"6",
							"1110000" when x"7",
							"1111111" when x"8",
							"1111011" when x"9",			 
										 
							"-------" when others;

end estructura;