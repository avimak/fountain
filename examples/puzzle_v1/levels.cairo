%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import (unsigned_div_rem, assert_le, abs_value)
from contracts.structs import (Vec2, LevelState)
from contracts.constants import (FP)

#########################

# view function for the public to pull from and examine
## TODO: refactor this to allow cleaner level management
@view
func pull_level {
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    } (
        id : felt
    ) -> (
        level_state : LevelState
    ):
    alloc_locals

    if id == 0:
        return( LevelState(
            score0_ball = Vec2(60 *FP, 160 *FP),
            score1_ball = Vec2(210 *FP, 160 *FP),
            forbid_ball = Vec2(125 *FP, 160 *FP),
            player_ball = Vec2(40 *FP, 40 *FP)
        ))
    end

    if id == 1:
        return( LevelState(
            score0_ball = Vec2(80 *FP,  150 *FP),
            score1_ball = Vec2(180 *FP, 175 *FP),
            forbid_ball = Vec2(80 *FP,  200 *FP),
            player_ball = Vec2(175 *FP, 40 *FP)
        ))
    end

    if id == 2:
        return( LevelState(
            score0_ball = Vec2( 125*FP,   100*FP),
            score1_ball = Vec2( 125*FP,  50*FP),
            forbid_ball = Vec2( 125*FP, 150*FP),
            player_ball = Vec2( 125*FP,  230*FP)
        ))
    end

    if id == 3:
        return( LevelState(
            score0_ball = Vec2( 175*FP,   90*FP),
            score1_ball = Vec2( 90*FP,  125*FP),
            forbid_ball = Vec2( 50*FP,   175*FP),
            player_ball = Vec2( 200*FP,  40*FP)
        ))
    end

    if id == 4:
        return( LevelState(
            score0_ball = Vec2( 200*FP,   62*FP),
            score1_ball = Vec2( 62*FP,  200*FP),
            forbid_ball = Vec2( 125*FP,   125*FP),
            player_ball = Vec2( 20*FP,  20*FP)
        )) 
    else:
        with_attr error_message("Invalid level id"):
            assert 1 = 0
            return( LevelState(
                Vec2(0,0),
                Vec2(0,0),
                Vec2(0,0),
                Vec2(0,0)
            ))
        end
    end
end


func assert_legal_velocity {
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    } (velocity : Vec2) -> ():

    #
    # Contraint to initial velocity:
    #   vx^2 + vy^2 <= 2* (150*FP)^2
    #
    tempvar v_sq = velocity.x * velocity.x + velocity.y * velocity.y

    with_attr error_message("Illegla initial velocity: magnitude out of bound."):
        assert_le (v_sq, 2*150*FP*150*FP)
    end

    return ()
end
