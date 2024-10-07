library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
    Port(   i_clkDP : in STD_LOGIC;
           i_rstDP : in STD_LOGIC;
           i_dataDP : in STD_LOGIC_VECTOR (7 downto 0);
           o_dataDP: out STD_LOGIC_VECTOR (7 downto 0);
           o_addrDP : out STD_LOGIC_VECTOR (15 downto 0);

           r1_loadDP : in STD_LOGIC;
           r2_loadDP : in STD_LOGIC;
           r3_loadDP : in STD_LOGIC;
           r4_loadDP : in STD_LOGIC;
           r5_loadDP : in STD_LOGIC;
           r6_loadDP : in STD_LOGIC;
           r7_loadDP : in STD_LOGIC;
           r8_loadDP : in STD_LOGIC;

           m1_selDP : in STD_LOGIC_VECTOR (1 downto 0);
           m2_selDP : in STD_LOGIC_VECTOR (1 downto 0);
           m3_selDP : in STD_LOGIC;
           m4_selDP : in STD_LOGIC;
           m5_selDP : in STD_LOGIC_VECTOR (1 downto 0);
           s_selDP : in STD_LOGIC_VECTOR (2 downto 0);

           o_endDP : out STD_LOGIC
    );
end datapath;

architecture Behavioral of datapath is
signal o_reg1 : STD_LOGIC_VECTOR (7 downto 0);
signal o_reg2 : STD_LOGIC_VECTOR (1 downto 0);
signal o_reg3 : STD_LOGIC_VECTOR (1 downto 0);
signal o_reg4 : STD_LOGIC_VECTOR (1 downto 0);
signal o_reg5 : STD_LOGIC_VECTOR (1 downto 0);
signal o_reg6 : STD_LOGIC_VECTOR (7 downto 0);
signal o_reg7 : STD_LOGIC_VECTOR (15 downto 0);
signal o_reg8 : STD_LOGIC_VECTOR (15 downto 0);

signal sum1 : STD_LOGIC_VECTOR(15 downto 0);
signal sum2 : STD_LOGIC_VECTOR(15 downto 0);
signal sum3 : STD_LOGIC_VECTOR(15 downto 0);

signal o_sel : STD_LOGIC;

signal p1k : STD_LOGIC;
signal p2k : STD_LOGIC;
signal yk : STD_LOGIC_VECTOR(1 downto 0);

--signal conc2 : STD_LOGIC_VECTOR(7 downto 0); non so se serve con un reg

signal m1 : STD_LOGIC;
signal m2 : STD_LOGIC;
signal m3 : STD_LOGIC_VECTOR(15 downto 0);
signal m4 : STD_LOGIC_VECTOR(15 downto 0);

signal d1 : STD_LOGIC;
signal d2: STD_LOGIC;

begin
    --ff 1
    process(i_clkDP, i_rstDP)
    begin
        if(i_rstDP = '1') then
            d1 <= '0';
        elsif i_clkDP'event and i_clkDP = '1' then
            d1 <= m1;
        end if;
    end process;

    --ff 2
    process(i_clkDP, i_rstDP)
    begin
        if(i_rstDP = '1') then
            d2 <= '0';
        elsif i_clkDP'event and i_clkDP = '1' then
            d2 <= m2;
        end if;
    end process;
   
    --reg1
    process(i_clkDP, i_rstDP)
    begin
        if(i_rstDP = '1') then
            o_reg1 <= "00000000";
        elsif i_clkDP'event and i_clkDP = '1' then
            if(r1_loadDP = '1') then
                o_reg1 <= i_dataDP;
            end if;
        end if;
    end process;

   with s_selDP select
        o_sel <= o_reg1(7)when "000",
                 o_reg1(6)when "001",
                 o_reg1(5)when "010",
                 o_reg1(4)when "011",
                 o_reg1(3)when "100",
                 o_reg1(2)when "101",
                 o_reg1(1)when "110",
                 o_reg1(0)when "111",
                'X' when others;

   --reg2
    process(i_clkDP, i_rstDP)
    begin
        if(i_rstDP = '1') then
            o_reg2 <= "00";
        elsif i_clkDP'event and i_clkDP = '1' then
            if(r2_loadDP = '1') then
                o_reg2 <= yk;
            end if;
        end if;
    end process;

    --reg3
    process(i_clkDP, i_rstDP)
    begin
        if(i_rstDP = '1') then
            o_reg3 <= "00";
        elsif i_clkDP'event and i_clkDP = '1' then
            if(r3_loadDP = '1') then
                o_reg3 <= yk;
            end if;
        end if;
    end process;

    --reg4
    process(i_clkDP, i_rstDP)
    begin
        if(i_rstDP = '1') then
            o_reg4 <= "00";
        elsif i_clkDP'event and i_clkDP = '1' then
            if(r4_loadDP = '1') then
                o_reg4 <= yk;
            end if;
        end if;
    end process;

    --reg5
    process(i_clkDP, i_rstDP)
    begin
        if(i_rstDP = '1') then
            o_reg5 <= "00";
        elsif i_clkDP'event and i_clkDP = '1' then
            if(r5_loadDP = '1') then
                o_reg5 <= yk;
            end if;
        end if;
    end process;

    --reg6
    process(i_clkDP, i_rstDP)
    begin
        if(i_rstDP = '1') then
            o_reg6 <= "00000000";
        elsif i_clkDP'event and i_clkDP = '1' then
            if(r6_loadDP = '1') then
                o_reg6 <= i_dataDP;
           end if;
        end if;
    end process;      

   


    o_dataDP <= o_reg2 & o_reg3 & o_reg4 & o_reg5 ;
-- ==?
    o_endDP <= '1' when (("00000000" & o_reg6) = o_reg7) else '0';
--sum1
    sum1 <= (o_reg7 + "0000000000000001");
--sum2
    sum2 <= ("0000000000000001" + o_reg8);
--sum3
    sum3 <= ("0000000000000010" + o_reg8);
--XOR                    
    p2k <= ((o_sel xor d1) xor d2);
    p1k <= (o_sel xor d2);
--y                
    yk <= (p1k & p2k);

with m1_selDP select
        m1 <= o_sel when "01",
                '0'   when "00",
                 d1   when "10",
                 'X' when others;
           
 with m2_selDP select
        m2 <=  d1  when "01",
                '0' when "00",
                 d2  when "10",
                 'X'   when others;

with m3_selDP select
        m3 <= "0000000000000000" when '0',
                    sum1 when '1',
                    "XXXXXXXXXXXXXXXX" when others;

--reg7
    process(i_clkDP, i_rstDP)
    begin
        if(i_rstDP = '1') then
            o_reg7 <= "0000000000000000";
        elsif i_clkDP'event and i_clkDP = '1' then
            if(r7_loadDP = '1') then
                o_reg7 <= m3;
            end if;
        end if;
    end process;

--m4
    with m4_selDP select
        m4 <= "0000001111101000" when '0',
                    sum3 when '1',
                    "XXXXXXXXXXXXXXXX" when others;

 --reg8
    process(i_clkDP, i_rstDP)
    begin
        if(i_rstDP = '1') then
            o_reg8 <= "0000000000000000";
        elsif i_clkDP'event and i_clkDP = '1' then
            if(r8_loadDP = '1') then
                o_reg8 <= m4;
            end if;
        end if;
    end process;

--m5
  with m5_selDP select
        o_addrDP <= sum1 when "01",
                "0000000000000000"   when "00",
                 o_reg8   when "10",
                 sum2 when others;

end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity project_reti_logiche is
    Port ( i_clk         : in  std_logic;
            i_start       : in  std_logic;
            i_rst         : in  std_logic;
            i_data        : in  std_logic_vector(7 downto 0);
            o_address     : out std_logic_vector(15 downto 0);
            o_done        : out std_logic;
            o_en          : out std_logic;
            o_we          : out std_logic;
            o_data        : out std_logic_vector (7 downto 0)
           );

end project_reti_logiche;

architecture Behavioral of project_reti_logiche is
component datapath is
    Port(  i_clkDP : in STD_LOGIC;
           i_rstDP : in STD_LOGIC;
           i_dataDP : in STD_LOGIC_VECTOR (7 downto 0);
           o_dataDP: out STD_LOGIC_VECTOR (7 downto 0);
           o_addrDP : out STD_LOGIC_VECTOR (15 downto 0);

           r1_loadDP : in STD_LOGIC;
           r2_loadDP : in STD_LOGIC;
           r3_loadDP : in STD_LOGIC;
           r4_loadDP : in STD_LOGIC;
           r5_loadDP : in STD_LOGIC;
           r6_loadDP : in STD_LOGIC;
           r7_loadDP : in STD_LOGIC;
           r8_loadDP : in STD_LOGIC;

           m1_selDP : in STD_LOGIC_VECTOR (1 downto 0);
           m2_selDP : in STD_LOGIC_VECTOR (1 downto 0);
           m3_selDP : in STD_LOGIC;
           m4_selDP : in STD_LOGIC;
           m5_selDP : in STD_LOGIC_VECTOR (1 downto 0);
           s_selDP : in STD_LOGIC_VECTOR (2 downto 0);

           o_endDP : out STD_LOGIC
    );

end component;

signal    r1_load :  STD_LOGIC;
signal          r2_load :  STD_LOGIC;
signal          r3_load :  STD_LOGIC;
signal         r4_load :  STD_LOGIC;
signal          r5_load :  STD_LOGIC;
signal          r6_load :  STD_LOGIC;
signal          r7_load :  STD_LOGIC;
signal         r8_load :  STD_LOGIC;

signal          m1_sel :  STD_LOGIC_VECTOR (1 downto 0);
signal          m2_sel :  STD_LOGIC_VECTOR (1 downto 0);
signal           m3_sel :  STD_LOGIC;
signal        m4_sel :  STD_LOGIC;
signal         m5_sel :  STD_LOGIC_VECTOR (1 downto 0);
signal          s_sel :  STD_LOGIC_VECTOR (2 downto 0);

signal         o_end :  STD_LOGIC;
type S is(S0,S1,S2,S2wait,S3,S4,S4Wait,S5,S5Wait,S6,S6Wait,S7,S7Wait,S8,S8Wait,S9,S9Wait,s10,s10Wait,S11,S11Wait,S12,S12Wait,S13,S13Wait,S14,S14Wait,S15);

signal cur_state, next_state : S ;

begin
DATAPATH1 : datapath port map (      
           i_clkDP => i_clk,
           i_rstDP => i_rst,
           i_dataDP =>  i_data,
           o_dataDP =>  o_data,
           o_addrDP => o_address,

           r1_loadDP => r1_load,
           r2_loadDP => r2_load,
           r3_loadDP => r3_load,
           r4_loadDP => r4_load,
           r5_loadDP => r5_load,
           r6_loadDP => r6_load,
           r7_loadDP => r7_load,
           r8_loadDP => r8_load,

           m1_selDP => m1_sel,
           m2_selDP => m2_sel,
           m3_selDP => m3_sel,
           m4_selDP => m4_sel,
           m5_selDP => m5_sel,
           s_selDP => s_sel,

           o_endDP => o_end
);
  process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            cur_state <= S0;
        elsif i_clk'event and i_clk = '1' then
            cur_state <= next_state;
        end if;
    end process;

  process(cur_state, i_start, o_end)
    begin
        next_state <= cur_state;
        case cur_state is
            when S0 =>
                if i_start = '1' then
                    next_state <= S1;
                end if;  
            when S1 =>
                next_state <= S2;
            when S2 =>
                next_state <= S2wait;
            when S2wait =>
                if o_end = '1' then
                    next_state <= S15;
                else
                    next_state <= S3;
                end if;
            when S3 =>
                next_state <= S4;
            when S4 =>
                next_state <= S4Wait;              
            when S4Wait =>
                next_state <= S5;
            when S5 =>
                next_state <= S5Wait;
            when S5Wait =>
                next_state <= S6;
            when S6 =>
                next_state <= S6Wait;
            when S6Wait =>
                next_state <= S7;
            when S7 =>
                next_state <= S7Wait;
            when S7Wait =>
                next_state <= S8;
            when S8 =>
                next_state <= S8Wait;
            when S8Wait =>
                next_state <= S9;
            when S9 =>
                next_state <= S9Wait;
            when S9Wait =>
                next_state <= S10;
            when S10 =>
                next_state <= S10Wait;
            when S10Wait =>
                next_state <= S11;
            when S11 =>
                next_state <= S11Wait;
            when S11Wait =>
                next_state <= S12;
            when S12 =>
                next_state <= S12Wait;
            when S12Wait =>
               next_state <= S13;
            when S13 =>
                next_state <= S13Wait;
            when S13Wait =>
                next_state <= S14;
            when S14 =>
                next_state <= S14Wait;
            when S14Wait =>
                if o_end= '1' then
                    next_state <= S15;
                else
                    next_state <= S3;
                end if;
            when S15 =>
                if i_start = '0' then
                     next_state <= S0;
                end if;
        end case;
  end process;
  process(cur_state)

  begin
    r1_load <= '0';
    r2_load <= '0';
    r3_load <= '0';
    r4_load <= '0';
    r5_load <= '0';
    r6_load <= '0';
    r7_load <= '0';
    r8_load <= '0';

    s_sel <= "000";
    m1_sel <= "10";
    m2_sel <= "10";
    m3_sel <= '1';
    m4_sel <= '1';
    m5_sel <= "00";

    o_en <= '0';
    o_we <= '0';
    o_done <= '0';

    case cur_state is
        when S0 =>
           r7_load <= '1';
            r8_load <= '1';
            m1_sel <= "00";
            m2_sel <= "00";
            m3_sel <= '0';
            m4_sel <= '0';
         
        when S1 =>
            o_en <= '1';
            m5_sel <= "00";
           
        when S2 =>
            r6_load <= '1';    

        when S3 =>
            o_en <= '1';
            m5_sel <= "01";

        when S4 =>
            
            r1_load <= '1';

        when S5 =>
            s_sel <= "000";
            m1_sel <= "01";
            m2_sel <= "01";
            r2_load <= '1';

        when S6 =>
            s_sel <= "001";
            m1_sel <= "01";
            m2_sel <= "01";
            r3_load <= '1';

        when S7 =>
            s_sel <= "010";
            m1_sel <= "01";
            m2_sel <= "01";
            r4_load <= '1';

        when S8 =>
            s_sel <= "011";
            m1_sel <= "01";
            m2_sel <= "01";
            r5_load <= '1';

        when S9 =>
            o_en <= '1';
            o_we <= '1';
            m5_sel <= "10";

        when S10 =>
            s_sel <= "100";
            m1_sel <= "01";
           m2_sel <= "01";
            r2_load <= '1';

        when S11 =>
            s_sel <= "101";
            m1_sel <= "01";
            m2_sel <= "01";
            r3_load <= '1';

        when S12 =>
            s_sel <= "110";
            m1_sel <= "01";
            m2_sel <= "01";
            r4_load <= '1';

        when S13 =>
            s_sel <= "111";
            m1_sel <= "01";
            m2_sel <= "01";
            r5_load <= '1';

        when S14 =>
            o_en <= '1';
            o_we <= '1';
            m5_sel <= "11";
            r7_load <= '1';
            r8_load <= '1'; 
    
         
        when S15 =>
            o_done <= '1';

        when others =>
            s_sel <= "000";
    end case;    

  end process;
end Behavioral;



