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

        type Index is range 0 .. 2;
        type my_array is array( Index ) of Integer;
        A : my_array;
        B : my_array;
        C : my_array;

        check_third : Integer := 0;
        R1          : Integer;
        R2          : Integer;
    begin
        counter := 0;

        While not End_Of_File( F ) loop
            data  := To_Unbounded_String( Get_Line( F ) );

            if check_third mod 3 = 0 then
                A( 0 ) := Integer'Value( To_String( data ) );
                B( 2 ) := Integer'Value( To_String( data ) );
                C( 1 ) := Integer'Value( To_String( data ) );
            elsif check_third mod 3 = 1 then
                A( 1 ) := Integer'Value( To_String( data ) );
                B( 0 ) := Integer'Value( To_String( data ) );
                C( 2 ) := Integer'Value( To_String( data ) );
            else
                A( 2 ) := Integer'Value( To_String( data ) );
                B( 1 ) := Integer'Value( To_String( data ) );
                C( 0 ) := Integer'Value( To_String( data ) );
            end if;

            if check_third > 2 then
                if check_third mod 3 = 0 then
                    R1 := A(0) + A(1) + A(2);
                    R2 := B(0) + B(1) + B(2);
                elsif check_third mod 3 = 1 then
                    R1 := B(0) + B(1) + B(2);
                    R2 := C(0) + C(1) + C(2);
                else
                    R2 := A(0) + A(1) + A(2);
                    R1 := C(0) + C(1) + C(2);
                end if;
                if R2 > R1 then 
                    counter := counter + 1;
                end if;
            end if;

            check_third := check_third + 1;
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
