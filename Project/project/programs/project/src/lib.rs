use anchor_lang::prelude::*;

declare_id!("HCNDgjPKom6hvzXb4tXwqqYviAXadAoJq2WhePFMLMRn");

#[program]
pub mod project {
    use super::*;

    pub fn initialize(ctx: Context<Initialize>) -> Result<()> {
        msg!("Greetings from: {:?}", ctx.program_id);
        Ok(())
    }
}

#[derive(Accounts)]
pub struct Initialize {}
