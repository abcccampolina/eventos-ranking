class ChunkyPNG::Image
    def to_base64
        Base64.strict_encode64 self.to_s
    end
end