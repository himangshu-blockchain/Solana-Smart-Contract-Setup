use anchor_lang::prelude::*;

declare_id!("q18xNEkzScp23NmKN8aKzeTPr6BbJLDe8LMD54FPhKe");

#[program]
pub mod solana_rewards {
    use super::*;

    pub fn initialize(ctx: Context<Initialize>) -> Result<()> {
        msg!("Greetings from: {:?}", ctx.program_id);
        Ok(())
    }
}

#[derive(Accounts)]
pub struct Initialize {}
