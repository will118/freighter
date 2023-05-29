select crates.name, array_agg(cv.version) as versions, count(dependency)
from crates_index.crates
         join crates_index.crate_versions cv on crates.id = cv.crate
         left join crates_index.dependencies d on crates.id = d.dependency
where crates.registry is null
  and position($1 in crates.name) > 0
group by crates.name
having count(cv.version) > 0
