import { QuartzComponent } from "./types"

const CampaignStatus: QuartzComponent = ({ fileData }) => {
  const latest = String(fileData.frontmatter?.latestSession ?? "")
  const updated = String(fileData.frontmatter?.lastUpdated ?? "")
  if (!latest || !updated) return null
  const format = (value: string) => new Date(`${value}T12:00:00Z`).toLocaleDateString("en-US", {
    month: "long", day: "numeric", year: "numeric", timeZone: "UTC",
  })
  return <div class="campaign-status">
    <div><span>Latest session</span><a class="internal" href={`./sessions/${latest}-game-notes`}>{format(latest)}</a></div>
    <div><span>Last updated</span><time dateTime={updated}>{format(updated)}</time></div>
  </div>
}
export default CampaignStatus
