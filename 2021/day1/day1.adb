with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure day1 is
    data    : Unbounded_String;
    F       : File_Type;
    current : Integer;
    last    : Integer;
    counter : Integer := 0;

    procedure Part_1(
        data    : out Unbounded_String;
        F       : File_Type;
        current : out Integer;
        last    : out Integer;
        counter : out Integer ) is 
    begin
        While not End_Of_File( F ) loop
            data := To_Unbounded_String( Get_Line( F ) );
            current := Integer'Value( To_String( data ) );
            if current > last then
                counter := counter + 1;
            end if;
            last := current;
        end loop;
        counter := counter - 1;
    end;

    procedure Part_2( 
        data    : out Unbounded_String;
        F       : File_Type;
        counter : out Integer ) is

        type Index is range 0 .. 2000;
        type my_array is array( Index ) of Integer;
        A : my_array;

        current : Integer := 0;
        last    : Integer := 0;
        idx     : Index   := 0;
    begin
        counter := 0;

        While not End_Of_File( F ) loop
            data  := To_Unbounded_String( Get_Line( F ) );
            A( idx ) := Integer'Value( To_String( data ) );
            idx := idx + 1;
        end loop;

        While idx >= 2 loop
            current := A( idx ) + A( idx - 1 ) + A( idx - 2 ); 
            if current < last then
                counter := counter + 1;
            end if;
            last := current;
            idx := idx - 1;
        end loop;
        counter := counter - 1;
    end;

begin
    Open( F, Mode => In_File, Name => "day1.input" );
    current := 0;
    last    := 0;
    
    --Part_1( data, F, current, last, counter );
    --Put(counter);

    counter := 0;
    
    Part_2( data, F, counter );
    Put(counter);

    Close( F );
end day1;
