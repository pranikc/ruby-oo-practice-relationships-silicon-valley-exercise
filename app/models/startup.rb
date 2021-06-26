class Startup
    attr_reader :name
    attr_accessor :domain, :founder
    @@all = []

    def initialize(name, founder, domain)
        @name = name
        @founder = founder
        @domain = domain
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_by_founder(founder)
        self.all.find{|startup| startup.founder == founder}
    end

    def self.domains
        self.all.map{|startup| startup.domain}.uniq
    end

    def sign_contract(venture_capitalist, type, investment)
        FundingRound.new(self, venture_capitalist, type, investment)
    end

    def funding_rounds
        FundingRound.all.select{|round| round.startup == self}
    end

    def num_funding_rounds
        self.funding_rounds.length
    end

    def total_funds
        investment_arr = self.funding_rounds.map{|round| round.investment}
        investment_arr.sum
    end

    def investors
        self.funding_rounds.map{|round| round.venture_capitalist}.uniq
    end

    def big_investors
        self.investors.select{|investor| VentureCapitalist.tres_commas_club.include?(investor) == true}.uniq
    end
end
