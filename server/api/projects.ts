import { serverSupabaseClient } from "#supabase/server";

export default eventHandler(async (event) => {
  const client = await serverSupabaseClient(event);
  const { data } = await client.from("projects").select().order("created_at");
  return data;
});
