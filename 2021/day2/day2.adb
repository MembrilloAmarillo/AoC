with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Bounded;   use Ada.Strings.Bounded;

procedure day2 is
    data    : Unbounded_String;
    F       : File_Type;
    type movement is ( up, down, forward );
    type Index is range 0 .. 1000;
    type my_array is array( Index ) of Unbounded_String;
    my_data    : my_array;
    idx        : Index := 0;
    horizontal : Integer := 0;
    depth      : Integer := 0;

    procedure parse_data is
    begin
        While not End_Of_File( F ) loop
            data  := To_Unbounded_String( Get_Line( F ) );
            my_data( idx ) := data;
            idx := idx + 1;
        end loop;
   end;

    function skip_to_number( str : Unbounded_String ) return Integer is
        stringed : String  := To_String( str );
        my_int   : Integer := 0;
    begin
        -- goes char by char until it get to the number
        for it of stringed loop
            if  it  >= '0' and it <= '9' then
                -- conversion from char to int
                my_int := Integer'Value( (1 => it) ); 
            end if;
        end loop;
        return my_int;
    end;

    function skip_to_space( str : Unbounded_String ) return movement is
        stringed : String := To_String ( str );
        this_mov : movement;
    begin
        -- it only needs to check for the first char of the string
        for it of stringed loop
            case it is
                when 'f' => this_mov := forward; exit;
                when 'd' => this_mov := down;    exit;
                when 'u' => this_mov := up;      exit;
                when ' ' => exit;

                when others => null;
            end case;
        end loop;
       return this_mov;
    end;

    procedure Part_1 is
        val : Integer;
        mov : movement;
        Res : Integer;
    begin
        idx := 0;
        while idx < 1000 loop
            mov := skip_to_space ( my_data( idx ) );
            val := skip_to_number( my_data( idx ) );
            case mov is
                when forward => horizontal := horizontal + val;
                when up      => depth      := depth - val;
                when down    => depth      := depth + val; 
            end case;
            idx := idx + 1;
        end loop;
        Res := horizontal * depth;
        Put( Res );
    end;

    procedure Part_2 is
            val : Integer;
            mov : movement;
            Res : Integer;
            aim : Integer := 0;
        begin
            idx        := 0;
            horizontal := 0;
            depth      := 0;
            while idx < 1000 loop
                mov := skip_to_space ( my_data( idx ) );
                val := skip_to_number( my_data( idx ) );
                case mov is
                    -- Now increase horizontal and depth values
                    when forward => horizontal := horizontal + val;
                                    depth      := depth + aim * val;
                    -- update aim
                    when up      => aim        := aim - val;
                    when down    => aim        := aim + val; 
                end case;
                idx := idx + 1;
            end loop;
            Res := horizontal * depth;
            Put( Res );
        end;
begin
    Open( F, Mode => In_File, Name => "day2.input" );

    parse_data;

    Part_1;
    Part_2;

    Close( F );
end day2;
