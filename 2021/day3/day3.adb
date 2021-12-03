with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Bounded;   use Ada.Strings.Bounded;

procedure day3 is
    type int_array is array( Integer range<> ) of Integer;
    type movement  is ( up, down, forward );
    type Index     is range 0 .. 1000;
    type my_array  is array( Index ) of Unbounded_String;
    my_data : my_array;
    F       : File_Type;
    idx     : Index := 0;
    size    : Integer;

    procedure parse_data is
        data : Unbounded_String;
    begin
        While not End_Of_File( F ) loop
            data  := To_Unbounded_String( Get_Line( F ) );
            my_data( idx ) := data;
            idx := idx + 1;
        end loop;
   end;

    function get_size_of_string( str : String ) return Integer is
        l_size : Integer := 0;
    begin
        l_size := str'Length;
        return l_size;
    end;

    procedure get_bit( str : String ; common_bit : out int_array ) is
        current_bit : Integer;
        counter     : Integer := 0;
        idx         : Integer := 0;
    begin
        for it of str loop
            current_bit := Integer'Value((1 => it));
            if current_bit = 1 then
                common_bit( idx ) := common_bit(idx) + 1;
            else 
                common_bit( idx ) := common_bit(idx) - 1;
            end if;
            idx := idx + 1;
        end loop;
    end;

    procedure Part_1( common_bit : out int_array ) is
        current_bit : Integer;
        idx         : Integer := 0;
    begin

        while idx < common_bit'Length loop
            common_bit( idx ) := 0;
            idx := idx + 1;
        end loop;
        idx := 0;

        for it of my_data loop
            get_bit( To_String( it ), common_bit );
        end loop;      

        while idx < To_String(my_data(0))'Length loop
            if common_bit(idx) < 0 then
                common_bit(idx) := 0;
                Put( 0 );
            else
                common_bit(idx) := 1;
                Put( 1 );
            end if;
            idx := idx + 1;
        end loop;
    end;

begin
    Open( F, Mode => In_File, Name => "day3.input" );

    parse_data;
    size := get_size_of_string( To_String( my_data( 0 ) ) );
    declare
        common_bit : int_array( 0 .. size );
    begin
        Part_1( common_bit );
    end;

    Close( F );
end day3;
