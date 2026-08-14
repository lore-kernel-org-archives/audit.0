Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348C62931D2
	for <audit@vger.kernel.org>; Fri, 14 Aug 2026 01:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672717; cv=none; b=rsxKPIY7jZJAvzSOko+Gprnrvu8EFIUKKq/ngIM0gx2O2wiotarImA/EIGByXaYvX4J1BNgQgX0FxgFl5hA9/jKEZKltQg+LfEmZAnc2M87HGFh4pWdpRGOfET4G0qtypXBwVEeyPkoSCBafkqU/0ZldYXJHH7YzoQ+56YmmyJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672717; c=relaxed/simple;
	bh=xh4GSCMaJGgGpXNr2gEGiYG2xeE1Yd0GG6b3XPUNxGk=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KVgatVzc0NPq7klBZyfyB9bK+1RQcGfBC5NsXFaYQBV9RJ6Ih6SJHr15uKLSelnYmh758NZK6uTlIlfS5wUIHF0gE9OhjYqTL6YgfSvlLwKg+BuOsfxBAi0BNhiwnPRFLVXEceLmKon85XTmxVr70hTsS9wj8i4lb5Mpyd/rGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ly8iQOAY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ly8iQOAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90DC1F000E9
	for <audit@vger.kernel.org>; Fri, 14 Aug 2026 01:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786672715;
	bh=xh4GSCMaJGgGpXNr2gEGiYG2xeE1Yd0GG6b3XPUNxGk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Ly8iQOAYbNfWZb+iWPEgWOWXkARpg9hbd+pKppzCW76JUz7n8Xy3rRjh6HlcwNCjz
	 TrpmKgzEqaSmdppZJKAY4Xz/e3WwihYzmlyebXtahU2A29THda4fwjChVP73ss6iD6
	 M26k7Vi18QpOosF3fLT2Qfjg6yjA+i+WoBHPQCqjdzy14kxBM9LOFwxN3Ldd0nmCWY
	 0YTQL6V1iD6sEGSedlRc83XhGzWwQjwl8P8Q9iS8yFdlpKQjdibWbvrWQysqgws/wx
	 UKpX+EyqIB5u3ihdNuPwuoiKAkoeBR5UlQC9Csjq2xDVUmA4232r6J6rSC4wzPzMwJ
	 kuXkdsya8liig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] audit: move the nlmsg_len fixup from __audit_log_end()
 to send time
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
In-Reply-To: <20260814010153.14488-1-include@grrlz.net>
References: <20260814010153.14488-1-include@grrlz.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:58:31 +0000
Message-Id: <20260814015835.B90DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

> Right now the auditd breakage (nlmsg_len gets set to the payload
> length instead of the full message length) is applied when the record
> is queued, in __audit_log_end(). That is why
> kauditd_send_multicast_skb() has to deep copy every record and then
> undo the length on the copy, just so the multicast group still sees a
> standard netlink message.
>=20
> So flip it: finalize the header with the standard full length at
> queue time, and apply the auditd length at send time in
> kauditd_send_queue(), right before the unicast. Records stay standard
> netlink messages the whole time they sit in the queues, and the
> multicast copy stops needing its own fixup. The copy itself stays,
> because the rewrite still lands in the data region the listeners
> already hold.
>=20
> auditd sees the same bytes as before: the fixup is computed from
> skb->len and that does not change between queueing and sending, so
> records that come back around through the retry and hold queues get
> the same value again. Reply and rule list skbs are built with
> nlmsg_put() and go out on their own paths, none of that is touched.
>=20
> This came out of reviewing Ricardo's "use copied skb length" patch,
> where I suggested moving the fixup as the more interesting cleanup.
>=20
> Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
> Tested-by: Ricardo Robaina <rrobaina@redhat.com>
> Signed-off-by: Bradley Morgan <include@grrlz.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814010153.1448=
8-1-include@grrlz.net?part=3D1

