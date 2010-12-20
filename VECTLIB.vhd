----------------------------------------------------------------------------------
-- Company		 : OCST Co.,Ltd.
-- Engineer		 : RyuShinHyung
-- 
-- Create Date	 : 07/04/2008
-- Design Name	 : 
-- Module Name	 : Vector package
-- Project Name	 : Railway Control
--
-- Revision
-- Revision 0.01 - File Created
-- Comments		 : Vector handle utility
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

-- declare VECTLIB package prototype
package vect_pack is

--	equvalent to conv_integer in Xilinx XST
function vect_to_int(a : STD_LOGIC_VECTOR)
return integer;

function vect_from(size : integer; val : integer)
return STD_LOGIC_VECTOR;

function vect8_from_char(ch : character)
return STD_LOGIC_VECTOR;


function vect_fill_one(size : integer)
return STD_LOGIC_VECTOR;

function vect_fill_zero(size : integer)
return STD_LOGIC_VECTOR;

function vect_test_allzero(a : STD_LOGIC_VECTOR)
return boolean;

function vect_test_anyzero(a : STD_LOGIC_VECTOR)
return boolean;

function vect_test_allone(a : STD_LOGIC_VECTOR)
return boolean;

function vect_test_anyone(a : STD_LOGIC_VECTOR)
return boolean;

function vect_each_or(a : STD_LOGIC_VECTOR)
return STD_LOGIC;



function log2_ceil(N : natural)
return positive;

function vect_gray(CODE : STD_LOGIC_VECTOR)
return STD_LOGIC_VECTOR;

function vect_invgray(CODE : STD_LOGIC_VECTOR)
return STD_LOGIC_VECTOR;

end vect_pack;


-- declare VECTLIB package body
package body vect_pack is

function vect_to_int(a : STD_LOGIC_VECTOR) return integer is
variable result : integer := 0;
begin
	if a'length = 0 then return result;
	end if;
	for i in a'reverse_range loop
		if a(i)='1' then result := result+2**i;
		end if;
	end loop;
	return result;
end vect_to_int;


function vect_from(size : integer; val : integer) return STD_LOGIC_VECTOR is
variable result : STD_LOGIC_VECTOR(size-1 downto 0);
variable tmp : integer;
begin
	tmp := val;
	for i in 0 to size-1 loop
		if tmp mod 2 = 1
		then result(i) := '1';
		else result(i) := '0';
		end if;
		tmp := tmp / 2;
	end loop;
	return result;
end vect_from;

function vect8_from_char(ch : character) return STD_LOGIC_VECTOR is
variable vect : std_logic_vector(7 downto 0);
begin
	vect := vect_from(8, character'pos(ch));
return vect;
end vect8_from_char;

-- return the vector have all '1'
function vect_fill_one(size : integer) return STD_LOGIC_VECTOR is
variable result : STD_LOGIC_VECTOR(size-1 downto 0);
begin
	for i in 0 to size-1 loop
		result(i) := '1';
	end loop;
	return result;
end vect_fill_one;

-- return the vector have all '0'
function vect_fill_zero(size : integer) return STD_LOGIC_VECTOR is
variable result : STD_LOGIC_VECTOR(size-1 downto 0);
begin
	for i in 0 to size-1 loop
		result(i) := '0';
	end loop;
	return result;
end vect_fill_zero;

-- 주어진 벡터가 모두 0인지 검사
function vect_test_allzero(a : STD_LOGIC_VECTOR) return boolean is
variable result : boolean := true;
begin
	for i in a'range loop
		if(a(i) = '1')
		then
			result := false;
		end if;
	end loop;
	return result;
end vect_test_allzero;


-- 주어진 벡터에 0이 있는지 검사
function vect_test_anyzero(a : STD_LOGIC_VECTOR) return boolean is
variable result : boolean := false;
begin
	for i in a'range loop
		if(a(i) = '0')
		then
			result := true;
		end if;
	end loop;
	return result;
end vect_test_anyzero;

-- 주어진 벡터가 모두 1인지 검사
function vect_test_allone(a : STD_LOGIC_VECTOR) return boolean is
variable result : boolean := true;
begin
	for i in a'range loop
		if(a(i) = '0')
		then
			result := false;
		end if;
	end loop;
	return result;
end vect_test_allone;

-- 주어진 벡터에 1이 있는지 검사
function vect_test_anyone(a : STD_LOGIC_VECTOR) return boolean is
variable result : boolean := false;
begin
	for i in a'range loop
		if(a(i) = '1')
		then
			result := true;
		end if;
	end loop;
	return result;
end vect_test_anyone;

-- 주어진 벡터의 각 요소를 OR
function vect_each_or(a : STD_LOGIC_VECTOR) return STD_LOGIC is
variable result : STD_LOGIC := '0';
begin
	for i in a'range loop
		result := result or a(i);
	end loop;
	return result;
end vect_each_or;

-- find minimum number of bits required to
-- represent N as an unsigned binary number
function log2_ceil(N : natural) return positive is
begin
	if(N < 2)
	then
		return 1;
	else
		return 1 + log2_ceil(N/2);
	end if;
end log2_ceil;


-- return the gray value of given binary number
function vect_gray(CODE : STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
begin
	return ("0" & CODE(CODE'length-1 downto 1)) xor CODE(CODE'length-1 downto 0);
end vect_gray;
--function vect2gray(vect : std_logic_vector) return std_logic_vector IS
--variable x : unsigned(vect'range) := unsigned(vect);
--begin
--	x := x xor shift_right(x,1);
--return std_logic_vector(x);
--end function vect2gray;


-- return the inverse gray value of given binary number
function vect_invgray(CODE : STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
variable result : STD_LOGIC_VECTOR(CODE'length-1 downto 0);
variable gray : STD_LOGIC;
begin
	gray := '0';
	for i in CODE'length-1 downto 0 loop
		result(i) := CODE(i) xor gray;
		gray := result(i);
	end loop;
	return result;
end vect_invgray;


end vect_pack;