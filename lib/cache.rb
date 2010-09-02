class Cache
  
  attr_reader :base_path

  MAX_SYSTEM_NUM = 999_999_999
  MAX_REVISION_NUM = 999

  def initialize(base_path)
    @base_path = base_path
  end

  # Returns the cache contents for the latest revision of +system_num+
  def find(system_num)
    path = latest_pathname(system_num)
    File.read(path) if path
  end

  # If needed, saves +data+ to the cache.
  # Will not save if data unchanged relative to the latest revision.
  def save(data, system_num)
    latest_data = find(system_num)
    if latest_data != data
      save_new_revision(data, system_num)
      :updated
    else
      :unchanged
    end
  end
  
  # Saves +data+ to the cache
  def save_new_revision(data, system_num)
    rev = latest_revision(system_num)
    new_revision = rev ? rev + 1 : 0
    path = pathname(system_num, new_revision)
    dir = File.dirname(path)
    FileUtils.mkdir_p(dir) unless File.exist?(dir)
    File.open(path, "w") { |f| f.write(data) }
    true
  end

  def latest_revision(system_num)
    path = latest_pathname(system_num)
    return nil unless path
    matches = path.match(%r{/\d{9}-(\d{3})\.xml})
    matches[1].to_i if matches
  end
  
  def pathname(system_num, revision_num)
    validate_system_num(system_num)
    validate_revision_num(revision_num)
    File.expand_path(
      "%s/%03i/%03i/%09i-%03i.xml" %
      [
        @base_path,
        system_num / 1_000_000,
        (system_num / 1_000) % 1_000,
        system_num,
        revision_num
      ]
    )
  end

  def latest_pathname(system_num)
    validate_system_num(system_num)
    pattern = File.expand_path(
      "%s/%03i/%03i/%09i-*.xml" %
      [
        @base_path,
        system_num / 1_000_000,
        (system_num / 1_000) % 1_000,
        system_num
      ]
    )
    Dir.glob(pattern).sort.last
  end

  def validate_system_num(system_num)
    unless (0 ... MAX_SYSTEM_NUM) === system_num
      raise "Out of range: system_num (#{system_num})"
    end
  end

  def validate_revision_num(revision_num)
    unless (0 ... MAX_REVISION_NUM) === revision_num
      raise "Out of range: revision_num (#{revision_num})"
    end
  end
  
end
