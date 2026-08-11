Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC73D891C
	for <audit@vger.kernel.org>; Tue, 11 Aug 2026 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486059; cv=none; b=pFqzxvdMBQOAKHYJ1r1SIVjTx0BOPPiWgvO+G/mV3CB+Qr6ZC3LuL2J7N57XGzKNFOgcaDW24XpZ1/+Rd9y7y+Csm+KRLq3oBlr05CPlDlVXlW2A8FpTUH/ln6sX+HBCnqhw44/qd2iaTOukGJ0AvvsPYhu0hNInoMK4/IgoMtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486059; c=relaxed/simple;
	bh=teNCltX216KujcfH6HCSGHeDyUuErSN7gPf+/3enC4M=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lOa7e2MkY1NgzVcbtcpQQYrjvstu00Yar19J7i8N0Pu+14d7chkOLEJoxu5ikq0a7TnB8DgT/pqhyS37Muypyjq5qeFu+0XPzQn3oawvoCo9CUfTnh+kEibIU3w8qismzQtTaLi79OFT/zGOC+pkReDzSdxajYFwBpySuznPHyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYKMayi1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYKMayi1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2971F00A3A
	for <audit@vger.kernel.org>; Tue, 11 Aug 2026 22:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786486058;
	bh=dmeTcFa1VTb1a82fUlHDgQ4u3A7KDi/byAZ8ZTk5qj0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=kYKMayi1lLffJ6TVErTxSO4F8O8MM8K4LfVkys5VEFzPbw0kOta9+Ok3Z3EFvlnjf
	 A6gerKBp9DAVOYQJuFpTL5DWr/MMn2hm21ePCSEB3miUOZrmJkHZ81EC/riaha6jDQ
	 qbNjrFZ4BTWjAgRtqPTjyV8zb8ExjXJd/uO9FKYfMaBfF7El+FIKLFfSVR2zWkahIY
	 PKkBRelR3N05/hjzB9SJu14dTX4SAgizEZAR/GeZ8elLEaV3tA74vVcnKd8l8vObTh
	 PV1zTSJyVaFgPNlqDBzTItn6UIMhncZLfA/Xw4zctFwSITOY8k65MifQ5pbGb/CPtM
	 GlVm1TiVXsEwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] audit: avoid dropping live tree ref on fsnotify rule
 autoremove
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
In-Reply-To: <20260811220128.275783-1-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260811220128.275783-1-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 22:07:37 +0000
Message-Id: <20260811220737.DA2971F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

> audit_del_rule() is used for both netlink deletion templates and internal
> fsnotify autoremove.  The former passes a parsed template which owns a
> temporary tree reference; the latter passes the installed entry itself.
>=20
> The unconditional audit_put_tree() at the end of audit_del_rule() assumes
> the template case.  For mixed AUDIT_DIR plus AUDIT_EXE rules, an fsnotify
> autoremove event therefore drops the installed rule's live tree reference.
> Repeating this across rules sharing the same tree can free the tree while
> another rule still references it, and a later autoremove dereferences the
> freed pathname while comparing rules.
>=20
> Move the temporary-tree put to audit_rule_change(), the caller that owns
> deletion templates.  Keep it in the AUDIT_DEL_RULE cleanup so both
> successful deletion and -ENOENT still release the parser-owned tree.
>=20
> Fixes: 34d99af52ad4 ("audit: implement audit by executable")
> Assisted-by: Codex:gpt-5
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811220128.2757=
83-1-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1

