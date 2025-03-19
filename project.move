module MyModule::AnonymousVoting {
    use aptos_framework::signer;
    use std::vector;

    struct Voting has store, key {
        votes: vector<u64>, // Stores vote counts for candidates
    }

    /// Function to initialize a new voting instance with a given number of candidates
    public fun initialize_voting(admin: &signer, num_candidates: u64) {
        let voting = Voting {
            votes: vector::empty<u64>(),
        };
        let i = 0;
        while (i < num_candidates) {
            vector::push_back(&mut voting.votes, 0);
            i = i + 1;
        };
        move_to(admin, voting);
    }

    /// Function to cast a vote anonymously for a candidate
    public fun vote(candidate_id: u64) acquires Voting {
        let voting = borrow_global_mut<Voting>(@0x1);
        assert!(candidate_id < vector::length(&voting.votes), 1);
        voting.votes[candidate_id] = voting.votes[candidate_id] + 1;
    }
}
