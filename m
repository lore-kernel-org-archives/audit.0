Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792637632;
	b=nDl44oN8CMOQOGCu97lOqlEFEsnGvomP5O3LEFYY1346zRP9W1GQQfdIQEgXGqdSsrnn
	 t/LjyogIAZrkyMS6o+tuXOSGEH0ql6D+3hX6eFegvrVhYYOA03+8gMKPGVjx23YnwDCBI
	 eE4isNs37iN5oOm5Plvb0gtdyq2JYg8QyaDrZ3SZQidRXP0tze2FROCXWC+6kr3LnareL
	 rkRRCDu2+06Sc7FZZqJNQtKyNkqis67XZ3x2Vm32SEF9dsHXX6ILXT+FlxJ/qq/k8Jd1P
	 Oa62Ua4UXtGy35iL5loZU//POFnY6wiTrKRMii5hAqHf8393uJ3NwCq8jxZFa50ZcyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
	b=1GoG5EafBOvzI71I/7lqrmQIpIvD7g25ecfx/aSlN/+PD/osomWK9G4x82/J1+2K60er
	 HTXwuDtaBy+Oa1AOrkYqmYYRpxK2yN9/Ja8ZUt3ObN+UcbqlYBG0sJYxGGpOXhGa/Gl7b
	 RGPkcRWJr0nDkNwD0E7qVuEnVnNPB5kgcgJxOQm1Zz/iJVtnl8jjFQPT5Kh2Erh0tONOC
	 DiuRJaXSPQvPyEXCu7hiS/U/99dI06JSn9IuKIA6M+iPVoaPSoIHpJ79A3EpKANTbUdnY
	 NW43C4MaJBTwvR1YWfEIAqi8DA024BjJTHGMKNa7bsa+QO7VD2uy36/3S8RVo1anObA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="DTOI/Pek";
	arc=fail smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CB4606A31B
	for <audit@vger.kernel.org>; Thu, 22 Oct 2026 02:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70CB4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DTOI/Pek
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so195494466b.3
        for <audit@vger.kernel.org>; Wed, 21 Oct 2026 19:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792637631; cv=none;
        d=google.com; s=arc-20260327;
        b=U/VKmSrvcaHWGgfturPF2g7wIiVY+ubrLJsKKjqzwt3w/7cln+AljUKfpsyJ452lbq
         qM2xzYvIjqgsXVlTM8KqYwNrlecs/UHCHX31KMJAcfjgMy8bRIUmqGWG/4dBfWEjl/7A
         YNiWUCDA/6WSqmsw/PeLUbGDFV6vLMQX4Uf4qptbpAzqXCqSIZEaEEAbStRz8RatmOE6
         73r9rqjZC6DMGwf9lfHUlP4s8RNCjTZ5Nr9OMoYT4SbBVlaVzPkrzuJBcVz2rWkfarU/
         RoGrvuZ6WBVv47It87GpyziSeVz7EUMhH2QSCDLSAZFydeMZt6/GXUNa2JOjBo/Ow0zI
         8Azw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        fh=bBzgq8NQNUK35d7OvPMwm4d6D3FFzOXdHq30LxMsZF4=;
        b=r2ey03POKDjFLp1eW9x99TRtjIdo7F/trDmGNR8RYafwhlzXhOrieWnC2yiIY4pQbm
         u5gnpbk48RKl9g0TbjOap5syRm+U2JI7VAT635Et83zwV0vvtBV563ww4B4u8K16tDrp
         /bmZl/rxG2mz+SXaWUx5SqChRjGxOV4HF/53AWZjNaZqdxWPhuGXyJFw+QbYIRXXEym8
         fiAfabHW3h2FIV+xmY3uFtVJS7GgTJK4xkBouJhp/0E6ePivWhulMFTQM5ec8Hgy1BWE
         7UZW30H7knUQc8KxOpYwNl6J4GCSt66+26HZ7QWURwlthcXkFGQD024g9F1sf8lNkuSx
         yLVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792637631; x=1793242431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        b=DTOI/PekpHCFwbCxS6btLnjWQNCiYVc9jJXCEYwAmPekEK8t/PxBNEKZNgCm5yMo5O
         ZHRqWqq6Sa4prnp5961iu97eKvO2fCe1P/oDhQUuXQyhe3en4gFePLH+ndAycKrOkdLY
         ZBtVPzCtW837QZIUsvIlXqXaajHAOKuqlnaym36x90uyaZGBsQGk0lDoH47TKDdTDSv/
         +bNghojo2jLNQuKI4CGPrg7pLnnWdQfj43K8C91aQyr5qb1zEo8L/J/KSRypGRSRs42E
         gu3hUif099K3NIyvd05k0+GuTWcbFOAPWaSRNh9N1gfC8G9MuampVJBqQHApn7d+PZp0
         CiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637631; x=1793242431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        b=eCZCoIsXQg0wFQTxueypa8Prafo6rHnKM2WBX0ezb84bsrvdQ9DFnkhJdD5MvkU1ew
         7aPXX+774R9C5gL2yqv88GeXGX+LgoiOdINmXDRvaqYVlOLpKishKJpE7F2TGrxa49OQ
         OzICpBgXzHBoJniK05VgVYdzj2QSdyO/3lbh2/6b2/b4480mBzCiyLCH3uMdr5IM0THR
         6kFzD1DyfLuVb0DDJ0iPYYLOhi4mz8voRnQsQbyTHH0D40tpjbHt2DbkbFGXedkY3HUO
         T/i5qtyZ/9Y8geddt8/evRY3wKUY+5gdYOGRFndGhZDe9DD6jAyWpjbr5gz6AAeinq82
         cT9w==
X-Forwarded-Encrypted: i=1; AKwUvBzLXrVD+PoT3qxKfnJmyhrQ3+vI8GvPng23cbiQ5RzmNtDGLOylUjG84Jk1o7vxpBLhsWLrfQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKsHOlsALpwR87VAO92aOztSgpIAp/A4fQr5/6JgYy+unGmzRjO
	eJUtknrqzLCwWJMlauC+CB2GNLNMJSKAaOBIC2Jxwsses/A8vtmOc9ivN9y9i4J3aXy5NiI+N9D
	1sVirQQEKa6khqmJtHJ4LLM/aEMtUsxo=
X-Gm-Gg: AYBFou1yEN+nbJxLz9pr0RjMgvkySURqnJoNebqljT1lHtLcI5VmWh5i24c+0LPUUt/
	huuWj05rukO4BzuATDI7VjHyFKL6aEKJePGZMJmKqoX48dM5Uate2P7RBFMTrix70PBlm9kDT7n
	ElU4LdLHgHh9ZMkDwau/SHY9q4CbBhyrFzy/PcsrfNNNeM09QUlELD1cHXMLKwOqg4X43P54gID
	Xgao8QR2JOfrCslMi+84VoVxen92PfCSZkt27GrdiptePEvkKcJxFElmmn/Sx9nD8ToeZmPlTeS
	mRi+tHlYb4e662BMeCClW5ljURxr2zz5qKEidGO8WNJBy3+r8taXz4HIcnxfGB5ErUIjCmCyqRX
	Ds+OZnLmtjeX03o3XDRrf2Hhkw7jcgJnfvXd2+KNOoq50I/u6CBmtRztvRQ==
X-Received: by 2002:a17:906:ba84:b0:c41:8e21:4d60 with SMTP id
 a640c23a62f3a-c46791326c1mr341731966b.1.1792637630664; Wed, 21 Oct 2026
 19:53:50 -0700 (PDT)
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792552161.git.jan.koester@tuxist.de> <f444dffc8e6bf98bf44c02456adc2de40e4ecd95.1792552161.git.jan.koester@tuxist.de>
 <fd20b840-350e-469c-9fd2-008fa0ded62a@slotpi15m67>
In-Reply-To: <fd20b840-350e-469c-9fd2-008fa0ded62a@slotpi15m67>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Thu, 22 Oct 2026 04:52:00 +0200
X-Gm-Features: AclHuK8zMCY_XzKvgZWVeEW29rK2WIKSmZA1a7YbTdfyZ3EtSnPZJ1CNUxd7pQ8
Message-ID: <CALWcw=FYKcDNXeArpsabHiQOAL+cWkF=L3stL6MB0OvVaHei1g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 40/41] nfsd, nfs: carry UUID and GUID owners as
 their text form
To: Chuck Lever <cel@kernel.org>
Cc: Jan Koester <jan.koester@tuxist.de>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, "Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, netdev@vger.kernel.org, audit@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 7:44=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On 10/20/26 11:16 PM, Jan Koester wrote:
> > Encode such an id as its text form -- "xxxxxxxx-xxxx-xxxx-xxxx-
> > xxxxxxxxxxxx" for a UUID, the same in braces for a GUID -- in both
> > directions on the server and the client, and take such a string (it
> > has no '@', so it can't be a user@domain name) as that id again.
>
> A bare UUID in an owner, owner_group, or ACE 'who' string is a new
> owner-string syntax for NFSv4, one that only Linux would recognize.
> Thus it isn't interoperable with other NFSv4 stacks as proposed
> here.
>
> RFC 8881 Section 5.9 says a string without an '@' that is not a
> decimal number means no translation was available and the receiver
> "should not use that string as a basis for translation into its
> own internal format." RFC 8000 Section 6.1 forbids bare numeric
> ids in multi-domain deployments because they collide; the same
> applies to bare UUIDs, and more so to GUIDs.
>
> If you are serious about pursuing this, you'll have to start by
> raising the proposed wire format on nfsv4@ietf.org before the
> Linux kernel's NFS stack commits to it.

I recall rumors of MS wanting to stick Windows SID in text form into
the NFSv4 protocol.

THIS proposal is even worse, in every imaginable way:
Stuff an unreadable 128bit blob everywhere. I am sure people having to
debug that in the kernel will LOVE the idea (compare blob a with blob
b as human,YAY!), and admins facing the 128bit hexdump will send
marriage proposals to the author, for making their lives even more
heartless and miserable.

NAK, -1, for the whole patch series.
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
